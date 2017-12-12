#Postavljamo base image (latest ubuntu, bolje promjeniti na odredjenu verziju ako ce se koristiti u produkciji)
FROM ubuntu

#Pokrecemo osnovne updateove i upgradeove pracene sa instalacijom pythona 3 i nužnih dodataka
RUN apt-get update && apt-get -y upgrade && apt-get install -y python3 && apt-get install -y build-essential libssl-dev libffi-dev python-dev

#Instaliravanje common packagea koji ce nam trebati
RUN apt-get install -y software-properties-common
RUN apt-get install -y wget
RUN apt-get install -y curl
RUN apt-get install git -y
RUN apt-get install python2.7 -y
RUN apt-get install vim  -y

#Dobavljamo java installer preko webupd8team repositorya
RUN add-apt-repository ppa:webupd8team/java -y

#Vršimo update pošto imamo novi repostory dodan
RUN apt-get update -y

#Pošto oracle zahtjeva prihvaćanje licence koja nisu (Y/N) moramo koristiti posebnu naredbu kako bi prihvatili terms & agreements
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections

#Pokrećemo java 8 instalaciju
RUN apt-get install oracle-java8-installer -y


#Instaliravamo postgresql i nuzne dodatke
RUN apt-get install -y postgresql postgresql-contrib

#Instaliramo ElasticSearch
RUN wget -O - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add -
RUN echo  "deb  http://packages.elastic.co/elasticsearch/2.x/debian stable main" | tee -a /etc/apt/sources.list.d/elasticsearch-2.x.list
RUN apt-get update &&  apt-get install elasticsearch -y

#Pošto je ovo Docker instance, moramo dopustiti SSH
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:password' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

#Resetiranje i postavljanje SSH-a kako bi mogli pokrenuti elasticsearch, inace se ne moze spojiti na bus
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
RUN service ssh restart


#Kopiramo pre-postavljeni .yml config file i stavljamo ga u docker ubuntu directory sa elasticsearchom
COPY elasticsearch.yml /etc/elasticsearch/elasticsearch.yml


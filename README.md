# Docker Task

A Dockerfile with necessary files to build a Docker Image with:
* python3 
* postgresql
* elasticsearch 
* java8
* some common packages

### Prerequisites
[Docker](https://docker.com)

### Installing


```
git clone https://github.com/AntonioErdeljac/Docker-Task.git
cd Docker-Task/
docker build -t docker_image .
```

## Running the tests

```
docker run -it -p 9200:9200 --name docker_container docker_image /bin/bash
```
Once you are **root@f8249c02deae**
```
service elasticsearch start
```

### Check versions

Check java version

```
java -version
```
Check postgresql version

```
psql --version
```

Check Elasticsearch version
```
curl http://localhost:9200
...
sample output:
{
  "name" : "Tech-Blog",
 "cluster_name" : "linux-point- development ",
  "cluster_uuid" : "huIY_z9fQnWhdUiQrqfyLA",
   "version" : {
     "number" : "2.4.5",
     "build_hash" : "19c13d0",
     "build_date" : "2017-07-18T20:44:24.823Z",
     "build_snapshot" : false,
     "lucene_version" : "6.6.0"
 },
  "tagline" : "You Know, for Search"
}
```

Check Python version
```
python3
```


## Built With

* [Docker](http://docker.com) 


## Versioning

Dockerfile uses latest version for all packages, if you are planning on production you should set everything to a fixed version.

## Authors

* **Antonio Erdeljac** - *Initial work* - [Docker Task](https://github.com/Docker-Task)

## Acknowledgments

* this was an assigment 


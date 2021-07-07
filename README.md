# vagrant-nomad-demo
Small demo using nomad in a vagrant box in dev mode.

## Usage

Start the vagrant box by issuing

    vagrant up

The nomad should be available under http://192.168.56.110:4646/

You can check the nomad version with

    vagrant ssh
    nomad -v

## Configuration files

Configuration files can be found at

    /etc/nomad.d

## Run the first job

You can generate a sample job file and start it

    nomad job init
    nomad job run example.nomad

You can check the allocation status with

    nomad job status example
    nomad alloc status 0c14d90b

Please ajust the ID.

Showing the job logs is easy

    nomad alloc logs 0c14d90b redis
or 

     nomad alloc logs -job redis

You can stop the job with

    nomad job stop example

## More examples

There are some example job configurations in the `nomad` folder.

### http-echo

You can plan the job scheduling by issuing

    nomad job plan http-echo.nomad

Run the job with

    nomad job run http-echo.nomad

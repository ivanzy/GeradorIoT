# A Simple Sensor Data Generator 

This simple java code generate a bunch of data from sintetic IoT sensors. It's possible to use 6 templates of time driven sensors and a template for event driven sensor (this template simulates a event, like a soccer game, and the sensor is put to monitor people entering and leaving this event, so , it behaves like a poisson function, with different lambdas for each period of time).
All the data is sent via MQTT protocol.

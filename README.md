# Quartus II Ultrasonic Range Sensor

Final Project for CET4805 - Component Subsystem Design at NYC College of Technology 
## Equipment                                                                                                           
</br>• Altera DE2 Board                                                                                                 
</br>• Misc. Jumper Cables                                                                                              
</br>• HR-SR04 Ultrasonic Ping Sensor                                                                                   
</br>                                                                                                              
Based on design by Mazhar Hussain for the Nexys 2 board(https://youtu.be/PJkiDAKVTFg)                                   
</br>                                                                                                              
Using the internal 50MHz clock from the Altera DE2 Board and Pulse Width Modulation, the DE2 Board can measure the distance of an object using an Ultrasonic Range Sensor originally intended for the Arduino.                                                                                                                                        </br>The sensor achieves this by setting off an ultrasonic ping at a set interval of milliseconds and then calculates the amount of time it takes for that ping to reach an object. Software is written in VHDL.

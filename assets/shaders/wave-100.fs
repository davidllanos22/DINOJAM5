#version 100

precision mediump float;

// Input vertex attributes (from vertex shader)
varying vec2 fragTexCoord;
varying vec4 fragColor;

// Input uniform values
uniform sampler2D texture0;
uniform vec4 colDiffuse;

uniform float seconds = 0.1;

uniform vec2 size = vec2(640 * 2, 480 * 2);
uniform float freqX = 25.0;
uniform float freqY = 25.0;
uniform float ampX = 5.0;
uniform float ampY = 5.0;
uniform float speedX = 8.0;
uniform float speedY = 8.0;

void main() {
    float pixelWidth = 1.0/size.x;
    float pixelHeight = 1.0/size.y;
    float aspect = pixelHeight/pixelWidth;
    float boxLeft = 0.0;
    float boxTop = 0.0;

    vec2 p = fragTexCoord;
    p.x += cos((fragTexCoord.y - boxTop)*freqX/(pixelWidth*750.0) + (seconds*speedX))*ampX*pixelWidth;
    p.y += sin((fragTexCoord.x - boxLeft)*freqY*aspect/(pixelHeight*750.0) + (seconds*speedY))*ampY*pixelHeight;

    gl_FragColor = texture2D(texture0, p)*colDiffuse*fragColor;
}
#version 100

precision mediump float;

varying vec2 fragTexCoord;
varying vec4 fragColor;

uniform sampler2D texture0;
uniform vec4 colDiffuse;

uniform float seconds;

uniform vec2 size;
uniform vec2 freq;
uniform vec2 amp;
uniform vec2 speed;

void main() {
    float pixelWidth = 1.0 / size.x;
    float pixelHeight = 1.0 / size.y;
    float aspect = pixelHeight / pixelWidth;
    float boxLeft = 0.0;
    float boxTop = 0.0;

    vec2 p = fragTexCoord;
    p.x += cos((fragTexCoord.y - boxTop) * freq.x / (pixelWidth * 750.0) + (seconds * speed.x)) * amp.x * pixelWidth;
    p.y += sin((fragTexCoord.x - boxLeft) * freq.y * aspect / (pixelHeight * 750.0) + (seconds * speed.y)) * amp.y *pixelHeight;

    gl_FragColor = texture2D(texture0, p) * colDiffuse * fragColor;
}
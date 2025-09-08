#version 330

in vec2 fragTexCoord;
in vec4 fragColor;

uniform sampler2D texture0;
uniform vec4 colDiffuse;

out vec4 finalColor;

uniform float seconds = 0.1;

uniform vec2 size = vec2(640 * 2, 480 * 2);
uniform vec2 freq = vec2(25.0, 25.0);
uniform vec2 amp = vec2(2.0, 2.0);
uniform vec2 speed = vec2(8.0, 8.0);

void main() {
    float pixelWidth = 1.0 / size.x;
    float pixelHeight = 1.0 / size.y;
    float aspect = pixelHeight / pixelWidth;
    float boxLeft = 0.0;
    float boxTop = 0.0;

    vec2 p = fragTexCoord;
    p.x += cos((fragTexCoord.y - boxTop) * freq.x / (pixelWidth * 750.0) + (seconds * speed.x)) * amp.x * pixelWidth;
    p.y += sin((fragTexCoord.x - boxLeft) * freq.y * aspect / (pixelHeight * 750.0) + (seconds * speed.y)) * amp.y *pixelHeight;

    finalColor = texture(texture0, p) * colDiffuse * fragColor;
}
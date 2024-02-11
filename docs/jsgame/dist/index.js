"use strict";
let shockwaves = [];
// Tweak these
const MAX_RADIUS = 100;
const SHOCK_COLOR = "black";
const SHOCK_DURATION = 500; // 1/2 second
const SHOCK_STROKE = 2;
const TIME_PERIOD = 1000; // ms
const RADIUS_PERIOD = 100; // px
// Don't tweak these
const TIME_COEFFICIENT = (2 * Math.PI) / TIME_PERIOD;
const RADIUS_COEFFICIENT = (2 * Math.PI) / RADIUS_PERIOD;
let time_sign = -1;
let COLORS = [];
calculateColors(); // technically unnecessary, but I don't like top-level loops
function calculateColors() {
    // red to yellow
    for (let i = 0; i < 256; i++) {
        COLORS.push({ r: 255, g: i, b: 0 });
    }
    // yellow to green
    for (let i = 0; i < 256; i++) {
        COLORS.push({ r: 255 - i, g: 255, b: 0 });
    }
    // green to blue
    for (let i = 0; i < 256; i++) {
        COLORS.push({ r: 0, g: 255 - i, b: i });
    }
    // blue to red
    for (let i = 0; i < 256; i++) {
        COLORS.push({ r: i, g: 0, b: 255 - i });
    }
}
function setPixel(imageData, x, y, r, g, b, a) {
    let index = (x + y * imageData.width) * 4;
    imageData.data[index + 0] = r;
    imageData.data[index + 1] = g;
    imageData.data[index + 2] = b;
    imageData.data[index + 3] = a;
}
function updateState(time) {
    shockwaves = shockwaves.filter((shockwave) => {
        if (shockwave.birth === undefined) {
            shockwave.birth = time;
        }
        let age = time - shockwave.birth;
        return age <= SHOCK_DURATION;
    });
}
// simulated shader (could use the real thing but this is simpler)
function shade(imageData, x, y, time) {
    const radius = Math.sqrt((x - imageData.width / 2) ** 2 + (y - imageData.height / 2) ** 2);
    const magnitude = Math.sin(time_sign * TIME_COEFFICIENT * time + RADIUS_COEFFICIENT * radius);
    const index = Math.floor(((magnitude + 1) / 2) * (COLORS.length - 1));
    const color = COLORS[index];
    setPixel(imageData, x, y, color.r, color.g, color.b, 255);
}
function render(time, canvas, ctx) {
    // background render
    let imageData = ctx.createImageData(canvas.width, canvas.height);
    for (let x = 0; x < canvas.width; x++) {
        for (let y = 0; y < canvas.height; y++) {
            shade(imageData, x, y, time);
        }
    }
    ctx.putImageData(imageData, 0, 0);
    // shockwave render
    shockwaves.forEach((shockwave) => {
        const progress = (time - shockwave.birth) / SHOCK_DURATION;
        ctx.globalAlpha = 1 - progress;
        ctx.beginPath();
        ctx.arc(shockwave.x, shockwave.y, progress * MAX_RADIUS, 0, Math.PI * 2);
        ctx.strokeStyle = shockwave.color;
        ctx.lineWidth = SHOCK_STROKE;
        ctx.stroke();
        ctx.globalAlpha = 1;
    });
}
document.addEventListener("DOMContentLoaded", () => {
    const canvas = document.getElementById("gameCanvas");
    const ctx = canvas.getContext("2d");
    canvas.addEventListener("click", (event) => {
        const rect = canvas.getBoundingClientRect();
        const x = event.clientX - rect.left;
        const y = event.clientY - rect.top;
        shockwaves.push({ x, y, color: SHOCK_COLOR });
        time_sign *= -1;
    });
    function gameLoop(time) {
        updateState(time);
        render(time, canvas, ctx);
        requestAnimationFrame(gameLoop);
    }
    // Start the game loop
    requestAnimationFrame(gameLoop);
});

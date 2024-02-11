"use strict";
document.addEventListener("DOMContentLoaded", () => {
    const canvas = document.getElementById("gameCanvas");
    const ctx = canvas.getContext("2d");
    canvas.addEventListener("click", (event) => {
        const rect = canvas.getBoundingClientRect();
        const x = event.clientX - rect.left;
        const y = event.clientY - rect.top;
        // Draw a circle at the click position
        drawCircle(ctx, x, y, "blue");
        // Change the color back after 3 seconds
        setTimeout(() => drawCircle(ctx, x, y, "white"), 3000);
    });
    function drawCircle(ctx, x, y, color) {
        ctx.fillStyle = color;
        ctx.beginPath();
        ctx.arc(x, y, 50, 0, Math.PI * 2, true);
        ctx.fill();
    }
});

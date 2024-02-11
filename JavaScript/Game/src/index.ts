interface Circle {
  x: number;
  y: number;
  color: string;
  lifespan: number; // Lifespan in milliseconds
}

// List of circles to be drawn
let circles: Circle[] = [];

document.addEventListener("DOMContentLoaded", () => {
  const canvas = document.getElementById("gameCanvas") as HTMLCanvasElement;
  const ctx = canvas.getContext("2d")!;
  const frameRate = 60; // Frames per second
  const frameDuration = 1000 / frameRate; // Duration of each frame in milliseconds

  canvas.addEventListener("click", (event) => {
    const rect = canvas.getBoundingClientRect();
    const x = event.clientX - rect.left;
    const y = event.clientY - rect.top;

    // Add a new circle on click with a 3-second lifespan
    circles.push({ x, y, color: "blue", lifespan: 3000 });
  });

  function gameLoop() {
    updateState();
    render(ctx);
    requestAnimationFrame(gameLoop);
  }

  function updateState() {
    // Update the lifespan of each circle
    circles = circles.filter((circle) => {
      circle.lifespan -= frameDuration;
      return circle.lifespan > 0;
    });
  }

  function render(ctx: CanvasRenderingContext2D) {
    // Clear the canvas
    ctx.clearRect(0, 0, canvas.width, canvas.height);

    // Draw each circle
    circles.forEach((circle) => {
      ctx.fillStyle = circle.color;
      ctx.beginPath();
      ctx.arc(circle.x, circle.y, 50, 0, Math.PI * 2);
      ctx.fill();
    });
  }

  // Start the game loop
  requestAnimationFrame(gameLoop);
});

interface Shockwave {
  x: number;
  y: number;
  color: string;
  birth?: number;
}

let shockwaves: Shockwave[] = [];

const MAX_RADIUS = 100;
const SHOCK_COLOR = "cyan";
const SHOCK_DURATION = 500; // 1/2 second
const SHOCK_STROKE = 2;

function updateState(time: number) {
  shockwaves = shockwaves.filter((shockwave) => {
    if (shockwave.birth === undefined) {
      shockwave.birth = time;
    }
    let age = time - shockwave.birth;
    return age <= SHOCK_DURATION;
  });
}

function render(
  time: number,
  canvas: HTMLCanvasElement,
  ctx: CanvasRenderingContext2D
) {
  ctx.fillStyle = "black";
  ctx.fillRect(0, 0, canvas.width, canvas.height);

  shockwaves.forEach((shockwave) => {
    const progress = (time - shockwave.birth!) / SHOCK_DURATION;
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
  const canvas = document.getElementById("gameCanvas") as HTMLCanvasElement;
  const ctx = canvas.getContext("2d")!;

  canvas.addEventListener("click", (event) => {
    const rect = canvas.getBoundingClientRect();
    const x = event.clientX - rect.left;
    const y = event.clientY - rect.top;

    shockwaves.push({ x, y, color: SHOCK_COLOR });
  });

  function gameLoop(time: number) {
    updateState(time);
    render(time, canvas, ctx);
    requestAnimationFrame(gameLoop);
  }

  // Start the game loop
  requestAnimationFrame(gameLoop);
});

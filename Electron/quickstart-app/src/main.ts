import { app, BrowserWindow } from 'electron'; // I changed this, as tutorial does 'require'
import path, { dirname } from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const createWindow = () => {
    const win = new BrowserWindow({
      width: 800,
      height: 600,
      webPreferences: {
        preload: path.join(__dirname, 'preload.js'), // absolute path required
      },
    })
  
    win.loadFile('index.html')
  }

app.whenReady().then(() => {
    createWindow()

    // New window on MacOS if activated with no windows
    app.on('activate', () => {
        if (BrowserWindow.getAllWindows().length === 0) createWindow()
      })
})

// Quit if all windows closed on Windows or Linux
app.on('window-all-closed', () => {
    if (process.platform !== 'darwin') app.quit()
})

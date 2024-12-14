import { app, BrowserWindow } from 'electron'; // I changed this, as tutorial does 'require'

const createWindow = () => {
    const win = new BrowserWindow({
      width: 800,
      height: 600
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

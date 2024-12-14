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
})

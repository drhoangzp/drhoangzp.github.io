const express = require('express');
const storage = require('node-persist');

const app = express();
app.use(express.json());

storage.init();

app.post('/shorten', async (req, res) => {
    const { url, shortUrl } = req.body;
    await storage.setItem(shortUrl, url);
    res.send(`Short URL is: ${req.protocol}://${req.get('host')}/${shortUrl}`);
});

app.get('/:shortUrl', async (req, res) => {
    const url = await storage.getItem(req.params.shortUrl);
    if (url) {
        res.redirect(url);
    } else {
        res.send('Short URL not found');
    }
});

app.listen(3000, () => console.log('Server is running on port 3000'));

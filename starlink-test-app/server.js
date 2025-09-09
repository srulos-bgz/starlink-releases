const express = require('express');
const cors = require('cors');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.static('public'));

// Serve static files from js-sdk
app.use('/js-sdk', express.static(path.join(__dirname, '..', 'js-sdk')));

// Routes
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.listen(PORT, '0.0.0.0', () => {
    console.log(`Starlink Test App running on http://0.0.0.0:${PORT}`);
    console.log(`Also accessible via http://localhost:${PORT}`);
});

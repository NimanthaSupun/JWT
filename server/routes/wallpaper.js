
const express = require('express');
const router = express.Router();

const axios = require('axios');


require('dotenv').config();


// search for wallpaper using API
router.get("/search", async (req, res)=>{
    const query = req.query.query;
    const apiKey = process.env.UNSPLASH_ACCESS_KEY;
    try{
        const response = await axios.get(
            `https://api.unsplash.com/search/photos?query=${query}`,
            {
              headers: {
                Authorization: `Client-ID ${apiKey}`,
              },
            }
          );
      
          const wallpapers = response.data.results.map((photo) => ({
            id: photo.id,
            url: photo.urls.regular,
            description: photo.description || photo.alt_description,
            photographer: photo.user.name,
          }));
      
          res.json({ wallpapers });
    } catch(error){
        return res.status(400).json({msg:"Error Fetching wallpaper"})
    }
})
module.exports = router;
const express = require("express");
const router = express.Router();
const User = require("../models/User");
const authMiddleware = require("../middleware/auth_middleware");

// Add wallpaper to favorites
router.post("/add", authMiddleware, async (req, res) => {
  const { id, url, description, photographer } = req.body;

  try {
    const user = await User.findById(req.user.id);
    const alreadyFavorited = user.favorites.some((fav) => fav.id === id);

    if (alreadyFavorited) {
      return res.status(400).json({ msg: "Wallpaper already in favorites" });
    }

    user.favorites.push({ id, url, description, photographer });
    await user.save();
    res.json(user.favorites);
  } catch (err) {
    res.status(500).json({ msg: "Server error" });
  }
});

// Remove wallpaper from favorites
router.post("/remove", authMiddleware, async (req, res) => {
  const { id } = req.body;

  try {
    const user = await User.findById(req.user.id);
    user.favorites = user.favorites.filter((fav) => fav.id !== id);
    await user.save();
    res.json(user.favorites);
  } catch (err) {
    res.status(500).json({ msg: "Server error" });
  }
});

// Get user favorites
router.get("/list", authMiddleware, async (req, res) => {
  try {
    const user = await User.findById(req.user.id);
    res.json(user.favorites);
  } catch (err) {
    res.status(500).json({ msg: "Server error" });
  }
});

module.exports = router;
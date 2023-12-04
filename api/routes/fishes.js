const express = require("express");
const router = express.Router();
const fishController = require("../controllers/fishControllers");

router.post("/add", fishController.addFish);
router.post("/edit", fishController.editFish);
router.post("/delete", fishController.deleteFish);
router.get("/category/:id", fishController.getFishByCategory);

module.exports = router;

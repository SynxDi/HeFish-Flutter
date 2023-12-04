const express = require("express");
const router = express.Router();
const fishTypesController = require("../controllers/fishTypesController");
router.get("/types", fishTypesController.getFishTypes);
module.exports = router;

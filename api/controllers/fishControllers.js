const createError = require("http-errors");
const { fishes, users, fish_types } = require("../models");

exports.getFishByCategory = async (req, res, next) => {
  try {
    const id = req.params.id;
    const fish = await fishes.findAll({
      where: {
        fish_type_id: id,
      },
      include: [
        {
          model: users,
          attributes: ["id", "username", "email"],
        },
        {
          model: fish_types,
          attributes: ["id", "name"],
        },
      ],
    });
    res.json({
      fishes: fish,
    });
  } catch (error) {
    next(error);
  }
};

exports.deleteFish = async (req, res, next) => {
  const { id } = req.body;
  try {
    const deleteFish = await fishes.destroy({
      where: {
        id: id,
      },
      truncate: false,
    });
    res.json({
      status: "success",
    });
  } catch (error) {
    next(error);
  }
};

exports.addFish = async (req, res, next) => {
  try {
    const { user_id, fish_type_id, name, description, price, image_path } =
      req.body;

    console.log({
      user_id: user_id,
      fish_type_id: fish_type_id,
      name: name,
      description: description,
      price: price,
      image_path: image_path,
    });
    const checkData = await fishes.findOne({
      order: [["id", "DESC"]],
    });
    await fishes.create({
      id: parseInt(checkData.id) + 1,
      user_id: parseInt(user_id),
      fish_type_id: parseInt(fish_type_id),
      name: name,
      description: description.substring(0, 49),
      price: parseInt(price),
      image_path: image_path,
    });

    res.json({
      status: "success",
    });
  } catch (error) {
    return next(createError(400, "Failed."));
  }
};

exports.editFish = async (req, res, next) => {
  try {
    const { id, name, description, fish_type_id, price, image_path } = req.body;
    await fishes.update(
      {
        name: name,
        description: description,
        fish_type_id: fish_type_id,
        price: parseInt(price),
        image_path: image_path,
      },
      {
        where: {
          id: id,
        },
      }
    );
    const fish = await fishes.findOne({
      where: {
        id: id,
      },
    });
    res.json({
      status: "success",
      fish,
    });
  } catch (error) {
    return next(createError(400, "Failed to update fish data."));
  }
};

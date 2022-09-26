const Student = require('../models/users')

module.exports = {
    getUsers: async (req, res) => {
        const students = await Student.find({});
        res.json({
            result: students.map(res => {
                return {
                    id: res.id,
                    name: res.name,
                    address: res.address
                }
            })
        })
    },
    insertUsers: async (req, res) => {
        const student = await new Student({
            name: req.body.name,
            address: req.body.address,
        }).save()
        res.json({
            "message": "done",
            name: student.name,
            address: student.address
        })
    },
    deleteUsers: async (req, res) => {
        const id = req.params.id;
        const deletedUser = await Student.findByIdAndDelete(id);
        res.json({ "user deleted": deletedUser });
    }
}
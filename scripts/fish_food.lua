local shape

function init(self)
    shape = self:get_child("Shape")

    shape:connect("collision", function(other)
        --print("collision")
    end)
end

function update(self, dt)
end

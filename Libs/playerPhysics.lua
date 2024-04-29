-- Made By O2Flash20 🙂

---Comes with the vectors library :).
PlayerPhysics = {}

importLib("vectors")

---A table of last positions. Meant for internal use by the library.
PlayerPhysics.pPoints = {}
---A table of last velocities. Meant for internal use by the library.
PlayerPhysics.vPoints = {}
-- Time that the library has been running.
PlayerPhysics.time = 0
---How much velocity data should be smoothed. A lower number will make PlayerPhysics.velocity react faster to real motion but output will be more noisy.
PlayerPhysics.velocitySmoothing = 10
---How much acceleration data should be smoothed. A lower number will make PlayerPhysics.acceleration react faster to real motion but output will be more noisy.
PlayerPhysics.accelerationSmoothing = 10

-- it may be an issue that the smoothing values are global for all scripts huh

---The player's position in the form of a vectors library vec.
PlayerPhysics.position = vec:new(0, 0, 0)
---The player's velocity in the form of a vectors library vec.
PlayerPhysics.velocity = vec:new(0, 0, 0)
---The player's acceleration in the form of a vectors library vec.
PlayerPhysics.acceleration = vec:new(0, 0, 0)

---Updates position, velocity, and acceleration. You must give it dt of whichever function it's in (preferably render or render3d).
function PlayerPhysics.update(dt)
    local px, py, pz = player.pposition()
    PlayerPhysics.time = PlayerPhysics.time + dt

    table.insert(PlayerPhysics.pPoints, vec:new(px, py, pz, PlayerPhysics.time))
    PlayerPhysics.position = vec:new(px, py, pz)

    -- remove excess data points
    while #PlayerPhysics.pPoints > PlayerPhysics.velocitySmoothing * 2 do
        table.remove(PlayerPhysics.pPoints, 1)
    end

    if #PlayerPhysics.pPoints == PlayerPhysics.velocitySmoothing * 2 then
        -- find average positions
        local avg1 = vec:new(0, 0, 0, 0)
        for i = 1, PlayerPhysics.velocitySmoothing do
            avg1:add(PlayerPhysics.pPoints[i])
        end
        avg1:div(PlayerPhysics.velocitySmoothing)

        local avg2 = vec:new(0, 0, 0, 0)
        for i = PlayerPhysics.velocitySmoothing + 1, 2 * PlayerPhysics.velocitySmoothing do
            avg2:add(PlayerPhysics.pPoints[i])
        end
        avg2:div(PlayerPhysics.velocitySmoothing)

        PlayerPhysics.velocity = vec
            :new(avg2.x, avg2.y, avg2.z)
            :sub(vec:new(avg1.x, avg1.y, avg1.z))
            :div(avg2.w - avg1.w)

        table.insert(
            PlayerPhysics.vPoints,
            PlayerPhysics.velocity:copy():setComponent("w", PlayerPhysics.time)
        )
    end

    -- remove excess data points
    while #PlayerPhysics.vPoints > PlayerPhysics.accelerationSmoothing * 2 do
        table.remove(PlayerPhysics.vPoints, 1)
    end

    if #PlayerPhysics.vPoints == PlayerPhysics.accelerationSmoothing * 2 then
        -- find average velocities
        avg1 = vec:new(0, 0, 0, 0)
        for i = 1, PlayerPhysics.accelerationSmoothing do
            avg1:add(PlayerPhysics.vPoints[i])
        end
        avg1:div(PlayerPhysics.accelerationSmoothing)

        avg2 = vec:new(0, 0, 0, 0)
        for i = PlayerPhysics.accelerationSmoothing + 1, 2 * PlayerPhysics.accelerationSmoothing do
            avg2:add(PlayerPhysics.vPoints[i])
        end
        avg2:div(PlayerPhysics.accelerationSmoothing)

        PlayerPhysics.acceleration = vec
            :new(avg2.x, avg2.y, avg2.z)
            :sub(vec:new(avg1.x, avg1.y, avg1.z))
            :div(avg2.w - avg1.w)
    end
end

"""
    numerical_integration_demo.jl

This script demonstrates different numerical integration methods for physical systems
and their energy conservation properties. We compare Euler, Heun, and symplectic Euler
methods on a simple pendulum and projectile motion.

These examples help visualize the concept of "energy drift" - how numerical approximations
can lead to non-conservation of energy even in conservative systems.
"""

using Plots
using LinearAlgebra
using Printf

"""
    euler_step(x, v, a_func, t, dt, params)

Perform one step of the Euler method.

# Arguments
- `x`: Position (scalar or vector)
- `v`: Velocity (scalar or vector)
- `a_func`: Function to calculate acceleration, of the form a_func(x, v, t, params)
- `t`: Current time
- `dt`: Time step
- `params`: Additional parameters for the acceleration function

# Returns
- Tuple of new position and velocity
"""
function euler_step(x, v, a_func, t, dt, params)
    a = a_func(x, v, t, params)
    x_new = x + v * dt
    v_new = v + a * dt
    return x_new, v_new
end

"""
    heun_step(x, v, a_func, t, dt, params)

Perform one step of Heun's method (improved Euler).
This is a second-order Runge-Kutta method.

# Arguments
- `x`: Position (scalar or vector)
- `v`: Velocity (scalar or vector)
- `a_func`: Function to calculate acceleration, of the form a_func(x, v, t, params)
- `t`: Current time
- `dt`: Time step
- `params`: Additional parameters for the acceleration function

# Returns
- Tuple of new position and velocity
"""
function heun_step(x, v, a_func, t, dt, params)
    # First, calculate the acceleration at the current state
    a1 = a_func(x, v, t, params)
    
    # Predict position and velocity using Euler method
    x_pred = x + v * dt
    v_pred = v + a1 * dt
    
    # Calculate acceleration at predicted position and velocity
    a2 = a_func(x_pred, v_pred, t + dt, params)
    
    # Average the accelerations and velocities
    a_avg = 0.5 * (a1 + a2)
    v_avg = 0.5 * (v + v_pred)
    
    # Update position and velocity using average values
    x_new = x + v_avg * dt
    v_new = v + a_avg * dt
    
    return x_new, v_new
end

"""
    symplectic_euler_step(x, v, a_func, t, dt, params)

Perform one step of the symplectic Euler method.
This method updates velocity first, then uses the new velocity to update position.
It better preserves energy in Hamiltonian systems.

# Arguments
- `x`: Position (scalar or vector)
- `v`: Velocity (scalar or vector)
- `a_func`: Function to calculate acceleration, of the form a_func(x, v, t, params)
- `t`: Current time
- `dt`: Time step
- `params`: Additional parameters for the acceleration function

# Returns
- Tuple of new position and velocity
"""
function symplectic_euler_step(x, v, a_func, t, dt, params)
    a = a_func(x, v, t, params)
    v_new = v + a * dt
    x_new = x + v_new * dt
    return x_new, v_new
end

"""
    pendulum_acceleration(theta, omega, t, params)

Calculate the acceleration for a simple pendulum.

# Arguments
- `theta`: Angular position (radians)
- `omega`: Angular velocity (radians/s)
- `t`: Current time (not used, included for API consistency)
- `params`: Parameters dictionary containing 'g' (gravity) and 'L' (pendulum length)

# Returns
- Angular acceleration
"""
function pendulum_acceleration(theta, omega, t, params)
    g = params["g"]
    L = params["L"]
    return -g/L * sin(theta)
end

"""
    projectile_acceleration(position, velocity, t, params)

Calculate the acceleration for projectile motion.

# Arguments
- `position`: Position vector [x, y]
- `velocity`: Velocity vector [vx, vy]
- `t`: Current time (not used, included for API consistency)
- `params`: Parameters dictionary containing 'g' (gravity)

# Returns
- Acceleration vector [ax, ay]
"""
function projectile_acceleration(position, velocity, t, params)
    g = params["g"]
    return [0.0, -g]
end

"""
    pendulum_potential_energy(theta, params)

Calculate the total energy of a pendulum.

# Arguments
- `theta`: Angular position (radians)
- `params`: Parameters dictionary containing 'g' (gravity), 'L' (pendulum length),
           and 'm' (pendulum mass)

# Returns
- Potential energy
"""
function pendulum_potential_energy(theta, params)
    g = params["g"]
    L = params["L"]
    m = params["m"]

    potential_energy = m * g * L * (1 - cos(theta))
    
    return potential_energy
end

"""
    pendulum_kinetic_energy(omega, params)

Calculate the total energy of a pendulum.

# Arguments
- `omega`: Angular velocity (radians/s)
- `params`: Parameters dictionary containing 'g' (gravity), 'L' (pendulum length),
           and 'm' (pendulum mass)

# Returns
- Kinetic Energy
"""
function pendulum_kinetic_energy(omega, params)
    g = params["g"]
    L = params["L"]
    m = params["m"]
    
    kinetic_energy = 0.5 * m * L^2 * omega^2
    
    return kinetic_energy
end

"""
    pendulum_energy(theta, omega, params)

Calculate the total energy of a pendulum.

# Arguments
- `theta`: Angular position (radians)
- `omega`: Angular velocity (radians/s)
- `params`: Parameters dictionary containing 'g' (gravity), 'L' (pendulum length),
           and 'm' (pendulum mass)

# Returns
- Total energy (kinetic + potential)
"""
function pendulum_energy(theta, omega, params)
    g = params["g"]
    L = params["L"]
    m = params["m"]
    
    kinetic_energy = pendulum_kinetic_energy(omega, params)
    potential_energy = pendulum_potential_energy(theta, params)
    
    return kinetic_energy + potential_energy
end

"""
    projectile_energy(position, velocity, params)

Calculate the total energy of a projectile.

# Arguments
- `position`: Position vector [x, y]
- `velocity`: Velocity vector [vx, vy]
- `params`: Parameters dictionary containing 'g' (gravity) and 'm' (mass)

# Returns
- Total energy (kinetic + potential)
"""
function projectile_energy(position, velocity, params)
    g = params["g"]
    m = params["m"]
    
    v_magnitude = norm(velocity)
    kinetic_energy = 0.5 * m * v_magnitude^2
    potential_energy = m * g * position[2]  # m*g*h, where h is the y-position
    
    return kinetic_energy + potential_energy
end

"""
    calculate_energy_drift(energies, initial_energy)

Calculate the relative energy drift from the initial energy.

# Arguments
- `energies`: Array of energy values at each time step
- `initial_energy`: Energy at the start of the simulation

# Returns
- Array of relative energy deviations (E - E_initial)/E_initial
"""
function calculate_energy_drift(energies, initial_energy)
    return (energies .- initial_energy) ./ initial_energy
end

"""
    simulate_pendulum(method_func, params, dt, t_end)

Simulate a pendulum using the specified numerical method.

# Arguments
- `method_func`: Function implementing the numerical method
- `params`: Parameters dictionary
- `dt`: Time step
- `t_end`: End time for simulation

# Returns
- Tuple of (times, positions, velocities, energies)
"""
function simulate_pendulum(method_func, params, dt, t_end)
    # Initial conditions
    theta0 = params["theta0"]
    omega0 = params["omega0"]
    
    # Initialize arrays to store results
    n_steps = Int(round(t_end/dt)) + 1
    times = collect(0:dt:t_end)
    thetas = zeros(n_steps)
    omegas = zeros(n_steps)
    energies = zeros(n_steps)
    
    # Set initial values
    thetas[1] = theta0
    omegas[1] = omega0
    energies[1] = pendulum_energy(theta0, omega0, params)
    
    # Time evolution
    for i in 1:(n_steps-1)
        thetas[i+1], omegas[i+1] = method_func(thetas[i], omegas[i], pendulum_acceleration, times[i], dt, params)
        energies[i+1] = pendulum_energy(thetas[i+1], omegas[i+1], params)
    end
    
    return times, thetas, omegas, energies
end

"""
    simulate_projectile(method_func, params, dt, t_end)

Simulate projectile motion using the specified numerical method.

# Arguments
- `method_func`: Function implementing the numerical method
- `params`: Parameters dictionary
- `dt`: Time step
- `t_end`: End time for simulation

# Returns
- Tuple of (times, positions, velocities, energies)
"""
function simulate_projectile(method_func, params, dt, t_end)
    # Initial conditions
    pos0 = params["pos0"]
    vel0 = params["vel0"]
    
    # Initialize arrays to store results
    n_steps = Int(round(t_end/dt)) + 1
    times = collect(0:dt:t_end)
    positions = zeros(n_steps, 2)
    velocities = zeros(n_steps, 2)
    energies = zeros(n_steps)
    
    # Set initial values
    positions[1,:] = pos0
    velocities[1,:] = vel0
    energies[1] = projectile_energy(pos0, vel0, params)
    
    # Time evolution
    i = 1
    while i < n_steps && positions[i,2] >= 0  # Stop if the projectile hits the ground
        positions[i+1,:], velocities[i+1,:] = method_func(positions[i,:], velocities[i,:], projectile_acceleration, times[i], dt, params)
        energies[i+1] = projectile_energy(positions[i+1,:], velocities[i+1,:], params)
        i += 1
    end
    
    # Truncate arrays if simulation ended early
    if i < n_steps
        times = times[1:i]
        positions = positions[1:i,:]
        velocities = velocities[1:i,:]
        energies = energies[1:i]
    end
    
    return times, positions, velocities, energies
end

"""
    plot_pendulum_trajectory(times, thetas, method_name)

Plot the angular position of a pendulum over time.

# Arguments
- `times`: Array of time points
- `thetas`: Array of angular positions
- `method_name`: Name of the numerical method (for plot title and legend)

# Returns
- Plot object
"""
function plot_pendulum_trajectory(times, thetas, method_name)
    plot(times, thetas, label=method_name, linewidth=2, title="Pendulum Angular Position",
         xlabel="Time (s)", ylabel="θ (radians)")
end

"""
    plot_projectile_trajectory(positions, method_name)

Plot the trajectory of a projectile in 2D space.

# Arguments
- `positions`: Matrix of positions, with rows as time steps and columns as [x, y]
- `method_name`: Name of the numerical method (for plot title and legend)

# Returns
- Plot object
"""
function plot_projectile_trajectory(positions, method_name)
    plot(positions[:,1], positions[:,2], label=method_name, linewidth=2, 
         title="Projectile Trajectory", xlabel="x (m)", ylabel="y (m)")
end

"""
    plot_energy_drift(times, energy_drift, method_name)

Plot the relative energy drift over time.

# Arguments
- `times`: Array of time points
- `energy_drift`: Array of relative energy deviations
- `method_name`: Name of the numerical method (for plot title and legend)

# Returns
- Plot object
"""
function plot_energy_drift(times, energy_drift, method_name)
    plot(times, energy_drift, label=method_name, linewidth=2, 
         title="Energy Drift", xlabel="Time (s)", 
         ylabel="Relative Energy Change (ΔE/E₀)")
end

"""
    run_pendulum_comparison()

Run and compare different numerical methods for the pendulum system.
"""
function run_pendulum_comparison()
    # Parameters for pendulum
    params = Dict(
        "g" => 9.81,    # Gravity (m/s²)
        "L" => 1.0,     # Pendulum length (m)
        "m" => 1.0,     # Mass (kg)
        "theta0" => π/4, # Initial angle (45 degrees)
        "omega0" => 0.0  # Initial angular velocity
    )
    
    dt = 0.05           # Time step (s)
    t_end = 10.0        # End time (s)
    
    # Run simulations with different methods
    times_euler, thetas_euler, omegas_euler, energies_euler = 
        simulate_pendulum(euler_step, params, dt, t_end)
    
    times_heun, thetas_heun, omegas_heun, energies_heun = 
        simulate_pendulum(heun_step, params, dt, t_end)
    
    times_symplectic, thetas_symplectic, omegas_symplectic, energies_symplectic = 
        simulate_pendulum(symplectic_euler_step, params, dt, t_end)
    
    # Calculate energy drift
    drift_euler = calculate_energy_drift(energies_euler, energies_euler[1])
    drift_heun = calculate_energy_drift(energies_heun, energies_heun[1])
    drift_symplectic = calculate_energy_drift(energies_symplectic, energies_symplectic[1])
    
    # Plot trajectories
    p1 = plot()
    plot!(p1, times_euler, thetas_euler, label="Euler", linewidth=2)
    plot!(p1, times_heun, thetas_heun, label="Heun", linewidth=2)
    plot!(p1, times_symplectic, thetas_symplectic, label="Symplectic Euler", linewidth=2)
    plot!(p1, title="Pendulum Angular Position", xlabel="Time (s)", ylabel="θ (radians)")
    
    # Plot energy drift
    p2 = plot()
    plot!(p2, times_euler, drift_euler, label="Euler", linewidth=2)
    plot!(p2, times_heun, drift_heun, label="Heun", linewidth=2)
    plot!(p2, times_symplectic, drift_symplectic, label="Symplectic Euler", linewidth=2)
    plot!(p2, title="Pendulum Energy Drift", xlabel="Time (s)", 
          ylabel="Relative Energy Change (ΔE/E₀)")
    
    # Print final energy drift values
    println("Final energy drift for pendulum:")
    @printf("  Euler: %.6f\n", drift_euler[end])
    @printf("  Heun: %.6f\n", drift_heun[end])
    @printf("  Symplectic Euler: %.6f\n", drift_symplectic[end])
    
    # Combine plots
    p = plot(p1, p2, layout=(2,1), size=(800,600))
    
    return p
end

"""
    run_projectile_comparison()

Run and compare different numerical methods for the projectile system.
"""
function run_projectile_comparison()
    # Parameters for projectile
    params = Dict(
        "g" => 9.81,               # Gravity (m/s²)
        "m" => 1.0,                # Mass (kg)
        "pos0" => [0.0, 0.0],      # Initial position
        "vel0" => [10.0, 15.0]     # Initial velocity
    )
    
    dt = 0.01                      # Time step (s)
    t_end = 5.0                    # End time (s)
    
    # Run simulations with different methods
    times_euler, positions_euler, velocities_euler, energies_euler = 
        simulate_projectile(euler_step, params, dt, t_end)
    
    times_heun, positions_heun, velocities_heun, energies_heun = 
        simulate_projectile(heun_step, params, dt, t_end)
    
    times_symplectic, positions_symplectic, velocities_symplectic, energies_symplectic = 
        simulate_projectile(symplectic_euler_step, params, dt, t_end)
    
    # Calculate energy drift
    drift_euler = calculate_energy_drift(energies_euler, energies_euler[1])
    drift_heun = calculate_energy_drift(energies_heun, energies_heun[1])
    drift_symplectic = calculate_energy_drift(energies_symplectic, energies_symplectic[1])
    
    # Plot trajectories
    p1 = plot()
    plot!(p1, positions_euler[:,1], positions_euler[:,2], label="Euler", linewidth=2)
    plot!(p1, positions_heun[:,1], positions_heun[:,2], label="Heun", linewidth=2)
    plot!(p1, positions_symplectic[:,1], positions_symplectic[:,2], label="Symplectic Euler", linewidth=2)
    plot!(p1, title="Projectile Trajectory", xlabel="x (m)", ylabel="y (m)")
    
    # Plot energy drift
    p2 = plot()
    plot!(p2, times_euler, drift_euler, label="Euler", linewidth=2)
    plot!(p2, times_heun, drift_heun, label="Heun", linewidth=2)
    plot!(p2, times_symplectic, drift_symplectic, label="Symplectic Euler", linewidth=2)
    plot!(p2, title="Projectile Energy Drift", xlabel="Time (s)", 
          ylabel="Relative Energy Change (ΔE/E₀)")
    
    # Print final energy drift values
    println("Final energy drift for projectile:")
    @printf("  Euler: %.6f\n", drift_euler[end])
    @printf("  Heun: %.6f\n", drift_heun[end])
    @printf("  Symplectic Euler: %.6f\n", drift_symplectic[end])
    
    # Combine plots
    p = plot(p1, p2, layout=(2,1), size=(800,600))
    
    return p
end

"""
    run_long_term_pendulum_comparison()

Run a long-term comparison of numerical methods for the pendulum system to demonstrate
the differences in energy conservation over extended periods.
"""
function run_long_term_pendulum_comparison()
    # Parameters for pendulum - using same parameters as before
    params = Dict(
        "g" => 9.81,    # Gravity (m/s²)
        "L" => 1.0,     # Pendulum length (m)
        "m" => 1.0,     # Mass (kg)
        "theta0" => π/4, # Initial angle (45 degrees)
        "omega0" => 0.0  # Initial angular velocity
    )
    
    # Use a longer time period and smaller time step
    dt = 0.05           # Time step (s)
    t_end = 100.0       # End time (s) - much longer simulation
    
    println("Running long-term pendulum simulation (t = 0 to $t_end s)...")
    
    # Run simulations with different methods
    # Skipping Euler because it will be too unstable for this long simulation
    times_heun, thetas_heun, omegas_heun, energies_heun = 
        simulate_pendulum(heun_step, params, dt, t_end)
    
    times_symplectic, thetas_symplectic, omegas_symplectic, energies_symplectic = 
        simulate_pendulum(symplectic_euler_step, params, dt, t_end)
    
    # Calculate energy drift
    drift_heun = calculate_energy_drift(energies_heun, energies_heun[1])
    drift_symplectic = calculate_energy_drift(energies_symplectic, energies_symplectic[1])
    
    # Plot energy space (kinetic vs potential) to show long-term behavior
    p1 = plot(
        thetas_heun,
        omegas_heun,
        # pendulum_potential_energy.(thetas_heun, Ref(params)), 
        # pendulum_kinetic_energy.(omegas_heun, Ref(params)), 
        label="Heun",
        title="Pendulum Energy Space",
        # ticks=-1:0.5:1,
        xlabel="theta (radians)", 
        ylabel="omega (rads/sec)"
    )
    plot!(p1, 
        thetas_symplectic,
        omegas_symplectic,
        # pendulum_potential_energy.(thetas_symplectic, Ref(params)), 
        # pendulum_kinetic_energy.(omegas_symplectic, Ref(params)), 
        label="Symplectic Euler",
        # aspect_ratio=1
    )
    
    # Plot energy drift
    p2 = plot(times_heun, drift_heun, label="Heun", linewidth=2, 
              title="Long-term Energy Drift", xlabel="Time (s)", 
              ylabel="Relative Energy Change (ΔE/E₀)")
    plot!(p2, times_symplectic, drift_symplectic, label="Symplectic Euler", linewidth=2)
    
    # Print final energy drift values
    println("Final energy drift after $(t_end) seconds:")
    @printf("  Heun: %.6f\n", drift_heun[end])
    @printf("  Symplectic Euler: %.6f\n", drift_symplectic[end])
    
    # Combine plots
    p = plot(p1, p2, layout=(2,1), size=(800,600))
    
    # # Also create a plot that shows the cumulative difference more clearly
    # cumulative_diff = abs.(drift_heun) - abs.(drift_symplectic)
    # p3 = plot(times_heun, cumulative_diff, linewidth=2, 
    #           title="Cumulative Difference in Energy Conservation",
    #           xlabel="Time (s)", ylabel="Difference in |ΔE/E₀|",
    #           label="Heun - Symplectic Euler")
    
    # # Combine all plots
    # p_all = plot(p1, p2, p3, layout=(3,1), size=(800,900))
    
    savefig(p, "long_term_pendulum_comparison.png")
    println("Long-term comparison plot saved as 'long_term_pendulum_comparison.png'.")
    
    return p
end

"""
    run_pendulum_resonance_test()

Run a special test case that demonstrates how non-symplectic methods can show
resonance phenomena that lead to energy growth over time.
"""
function run_pendulum_resonance_test()
    # Parameters for pendulum - slight modification to show resonance effects
    params = Dict(
        "g" => 9.81,    # Gravity (m/s²)
        "L" => 1.0,     # Pendulum length (m)
        "m" => 1.0,     # Mass (kg)
        "theta0" => π/6, # Initial angle (30 degrees)
        "omega0" => 0.5  # Initial angular velocity - non-zero to show interesting behavior
    )
    
    # Use a longer time period
    dt = 0.1            # Time step (s) - deliberately larger to show numerical effects
    t_end = 200.0       # End time (s) - very long simulation
    
    println("Running pendulum resonance test (t = 0 to $t_end s)...")
    
    # Run simulations with different methods
    times_heun, thetas_heun, omegas_heun, energies_heun = 
        simulate_pendulum(heun_step, params, dt, t_end)
    
    times_symplectic, thetas_symplectic, omegas_symplectic, energies_symplectic = 
        simulate_pendulum(symplectic_euler_step, params, dt, t_end)
    
    # Calculate energy drift
    drift_heun = calculate_energy_drift(energies_heun, energies_heun[1])
    drift_symplectic = calculate_energy_drift(energies_symplectic, energies_symplectic[1])
    
    # Plot energy over time
    p1 = plot(times_heun, energies_heun, label="Heun", linewidth=2, 
              title="Pendulum Energy Over Time", xlabel="Time (s)", 
              ylabel="Energy (J)")
    plot!(p1, times_symplectic, energies_symplectic, label="Symplectic Euler", linewidth=2)
    
    # Plot energy drift
    p2 = plot(times_heun, drift_heun, label="Heun", linewidth=2, 
              title="Energy Drift in Resonance Case", xlabel="Time (s)", 
              ylabel="Relative Energy Change (ΔE/E₀)")
    plot!(p2, times_symplectic, drift_symplectic, label="Symplectic Euler", linewidth=2)
    
    # Print final energy values
    println("Final energy after $(t_end) seconds:")
    @printf("  Initial energy: %.6f J\n", energies_heun[1])
    @printf("  Final energy (Heun): %.6f J\n", energies_heun[end])
    @printf("  Final energy (Symplectic): %.6f J\n", energies_symplectic[end])
    
    # Combine plots
    p = plot(p1, p2, layout=(2,1), size=(800,600))
    
    savefig(p, "pendulum_resonance_test.png")
    println("Resonance test plot saved as 'pendulum_resonance_test.png'.")
    
    return p
end

# Add these lines to the main function to run the new comparisons
function main_extended()
    # short term simulations
    # println("Running standard pendulum simulation...")
    # pendulum_plot = run_pendulum_comparison()
    # display(pendulum_plot)
    # savefig(pendulum_plot, "pendulum_comparison.png")
    
    # println("\nRunning projectile simulation...")
    # projectile_plot = run_projectile_comparison()
    # display(projectile_plot)
    # savefig(projectile_plot, "projectile_comparison.png")
    
    # long-term comparisons
    println("\nRunning long-term pendulum comparison...")
    long_term_plot = run_long_term_pendulum_comparison()
    display(long_term_plot)
    
    # println("\nRunning pendulum resonance test...")
    # resonance_plot = run_pendulum_resonance_test()
    # display(resonance_plot)
    
    println("\nAll simulations complete.")
end

# Run the extended demonstration
main_extended()
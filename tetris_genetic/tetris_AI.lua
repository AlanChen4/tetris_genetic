require 'tetris_controls'

POPULATION = {}

-- creates environment
function init_env()
  env = init_board()
end


-- creates random set of weights
function new_chromosome()
  local chromosome = {}
  for i = 1, 4 do 
    -- random weight between -1 and 1
    chromosome[i] = (math.random()*2)-1
  end
  return chromosome
end


function new_population()
  for i = 1, 16 do
    POPULATION[i] = new_chromosome()
  end
end


-- uses get_fitness as the evaluation for candidate solution
function get_fitness()
  return get_score()
end


function selection()
  -- body
end


function crossover()
  -- body
end


function mutation()
  -- body
end


function replacement()
  -- body
end


function get_decision()
 -- body
end


function load_current_weights(chromosome_weights)
  local current_weight_file = io.open('py_helpers/game_state/lua_weights.txt', 'w')

  io.output(current_weight_file)
  
  -- write the weights one by one (no table serialization)
  local weights_string = ''
  for i = 1, 4 do
    weights_string = weights_string .. ' ' .. chromosome_weights[i]
  end

  io.write(weights_string)
  io.close(current_weight_file)
end

function play_game(individual_number)
  -- play until game is lost
  print('Individual #' .. individual_number)
  local game_lost = false

  while not game_lost do
    -- if player has lost
    if memory.readbyte(0x0048) == 10 then
      update_info()
      print('Game Lost. Moving on to next individual')
      -- restart game
      savestate.load(ss_start)
      break
    end
    update_info()
    check_AI()
    emu.frameadvance()
  end
end


function main()
  -- start the game
  press_start()
  tetris_sleep()

  -- creates the starting save state for restarting the game
  ss_start = savestate.create(1)
  savestate.save(ss_start)

  -- create the population and load first chromosome
  new_population()
  for i = 1, 16 do
    local chromosome_weights = POPULATION[i]
    load_current_weights(chromosome_weights)
    play_game(i)
  end
end

main()

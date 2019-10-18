module Actions
  def self.move_snake(state)
    next_direction = state.next_direction
    next_position = calc_next_position(state)
    # verificar que la siguiente casilla
    if position_is_valid?(state, next_position)
      move_snake_to(state, next_position)
    else
      end_game(state)
    end

    private

    def calc_next_position(state)
      curr_position = state.snake.positions.first
      case state.next_direction
        when UP
          # decrementar fila
          # [(1,1), (0,1)]
          return Model::Cord.new(
            curr_position.row - 1,
            curr_position.col)
        when RIGHT
          # incremenar col
          return Model::Cord.new(
            curr_position.row,
            curr_position.col + 1)
        when DOWN
          # incrementar fila
          return Model::Cord.new(
            curr_position.row + 1,
            curr_position.col)
        when LEFT
          # decrementar col
          return Model::Cord.new(
            curr_position.row,
            curr_position.col - 1)
      end
    end
    # si no es valida -> terminar el juego
    # si es valida -> movemos la serpiente

    def position_is_valid(state, next_direction)
      # Verificar que este dentro de ka grilla
      is_invalid =  ((position.row >= state.grid.rows || position.row < 0 )||
        (position.col >= state.grid.cols || position.col < 0 ))

      return false if is_invalid
      # Verificar que no se este superponiendo a la serpiente
      return !(state.snake.positions.include? position)
    end
  end

  def move_snake_to
    # [(1,1),(1,0)]
    new_positions = [new_positions] + state.snake.positions[0...-1]
    state.snake.positions = new_positions
    state
  end

  def end_game(state)
    state.game_finished = true
    state
  end
end
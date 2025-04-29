extends Node

@export var initial_state: State #this exports initial state outside of script
var current_state :  State
var states : Dictionary = {}

func _ready() -> void: #this gets all states under statemachine
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
		print(states)
	if initial_state: #Here state machine enters initial state which is assigned outside of script
		initial_state.Enter()
		current_state = initial_state
		
func _process(delta): #updates node based on script in the state
	if current_state:
		current_state.Update(delta)
	
func _physics_process(delta: float) -> void: #updates node based on script in the state
	if current_state:
		current_state.Physics_Update(delta)

func on_child_transition(state, new_state_name): #if state sends transition signal this code switches to next state
	
	if state != current_state:
		return
		
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
		
	if current_state:
		current_state.Exit()
	
	new_state.Enter()
	
	current_state = new_state
	

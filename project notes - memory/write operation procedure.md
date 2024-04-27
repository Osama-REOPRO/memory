```wavedrom
{ 
signal : [
  { "name": "clk", 						"wave": "P.............." }, 
  { "name": "i_mem_operation", 			"wave": "01.........0..." }, 
  { "name": "i_address",    			"wave": "x=.........x...", "data": ["valid address"] },
  { "name": "o_mem_operation_done",		"wave": "0........1.0..." },
  { "name": "i_mem_write", 				"wave": "x1.............", "data": ["read data"] },
  { "name": "i_write_data", 			"wave": "x=.............", "data": ["valid data"] },
  { "name": "state", 	 				"wave": "73.......5.7...", "data": ['ready','busy', 'valid', 'ready'] },
  {},
  ['L0', 
   	{ "name": "o_state", 	 			"wave": "5.9.......5....", "data": ['valid', 'miss', 'valid'] },
   	{ "name": "state",  	 			"wave": "539......85....", "data": ['valid','lookup', 'wait_for_valid', 'load_missing', 'valid'] },
    { "name": "o_read_data", 			"wave": "x..............", "data": ["read data"] },
  ], {},
  ['L1', 
   	{ "name": "o_state",  	 			"wave": "5...7....5.....", "data": ['valid', 'hit', 'valid'] },
   	{ "name": "state",  	 			"wave": "5.3.7....5.....", "data": ['valid','lookup', 'write', 'valid'] },
    { "name": "o_read_data", 			"wave": "x........2.....", "data": ["read data"] },
  ], {},
  ['Physical', 
   	{ "name": "o_state", 	 			"wave": "5..............", "data": ['valid'] },
   	{ "name": "state",  	 			"wave": "5..............", "data": ['valid'] },
    { "name": "o_read_data", 			"wave": "x..............", "data": ["read data"] },
  ], {},
],
head: {text: ['tspan', {class:'h1'}, 'Read Operation']},
config: { hscale: 2 }
}
```
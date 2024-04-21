```wavedrom
{ 
signal : [
  { "name": "clk", 						"wave": "P.............." }, 
  { "name": "i_mem_operation", 			"wave": "01.........0..." }, 
  { "name": "o_ack", 					"wave": "0........1.0..." },
  { "name": "i_mem_write", 				"wave": "x0.............", "data": ["read data"] },
  { "name": "i_write_data", 			"wave": "x..............", "data": ["read data"] },
  { "name": "o_read_data", 				"wave": "x........=.x...", "data": ["read data"] },
  { "name": "state", 	 				"wave": "73.......5.7...", "data": ['ready','busy', 'valid', 'ready'] },
  {},
  ['L0', 
   	{ "name": "o_state", 	 			"wave": "5.9.......5....", "data": ['valid', 'miss', 'valid'] },
   	{ "name": "state",  	 			"wave": "539.......5....", "data": ['valid','lookup', 'miss', 'valid'] },
    { "name": "o_read_data", 			"wave": "x..............", "data": ["read data"] },
   	{ "name": "i_data_available", 		"wave": "x0.......1....."}
  ], {},
  ['L1', 
   	{ "name": "o_state",  	 			"wave": "5...7....5.....", "data": ['valid', 'hit', 'valid'] },
   	{ "name": "state",  	 			"wave": "5.3.7....5.....", "data": ['valid','lookup', 'hit', 'valid'] },
    { "name": "o_read_data", 			"wave": "x........2.....", "data": ["read data"] },
   	{ "name": "i_data_available", 		"wave": "x0.......1....."}
  ], {},
  ['Physical', 
   	{ "name": "o_state", 	 			"wave": "5..............", "data": ['valid'] },
   	{ "name": "state",  	 			"wave": "5..............", "data": ['valid'] },
    { "name": "o_read_data", 			"wave": "x..............", "data": ["read data"] },
   	{ "name": "i_data_available", 		"wave": "x0.......1....."}
  ], {},
],
head: {text: ['tspan', {class:'h1'}, 'Read Operation']},
config: { hscale: 2 }
}
```
Utility code used within Devisualization projects
====
[![Gitter](https://badges.gitter.im/Join Chat.svg)](https://gitter.im/Devisualization/util?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

**TODO:**
- Wrapper functions only go up to 1.5 (without legacy functions)
	Based upon [DOOGLE's wrapper code](https://raw.githubusercontent.com/rikkimax/DOOGLE/master/source/OpenGL/doogle/overloads/wrappers.d)
- Structify, not started but DOOGLE does have a start on it

**Subprojects**
- Core
- OpenGL
- Photoshop aco file reader/writer

Core
---
Scope has not been decided yet (unknown what is needed).

OpenGL
-----
__**Scope:**__ Any code required by other projects that is shared in their purposes.
- Wrappers, around OpenGL functions
- Structify, structs that represent and work from for e.g. a shader program 

Photoshop aco
-----
__**Scope:**__ Reads and writes ACO files (photoshop colour palette format).
Personal Lua modules.

Essential parts is 'base.lua' which provides request() -- require() relative to module's directory. And 'system.create_deploy_script.lua' which creates shell script to copy modules with dependencies.

Other files are resource base for programs. Programs are bundled with local copy of needed parts from this repository.

So no dead code in programs, alternative concept to versioning and I can redesign code here to whatever I please.

This repository started in 2016 as "code heap". And it's still code heap but for 2026 my vision is evolved.

-- Martin, 2026-04-22

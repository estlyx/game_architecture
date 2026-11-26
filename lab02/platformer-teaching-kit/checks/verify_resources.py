from pathlib import Path
import re, math, xml.etree.ElementTree as ET

root = Path(__file__).resolve().parents[1] / 'godot'
projects = sorted(root.glob('*/project.godot'))
assert len(projects) == 5, 'Expected five checkpoints'
checked = 0
for project in projects:
    folder = project.parent
    for file in folder.rglob('*'):
        if not file.is_file():
            continue
        if file.suffix in ('.tscn', '.godot', '.gd'):
            text = file.read_text(encoding='utf-8')
            for path in re.findall(r'res://([^"\n]+)', text):
                assert (folder / path).is_file(), f'{file}: missing {path}'
            if file.suffix == '.tscn':
                ext_ids = set(re.findall(r'\[ext_resource[^\n]* id="([^"]+)"', text))
                sub_ids = set(re.findall(r'\[sub_resource[^\n]* id="([^"]+)"', text))
                assert set(re.findall(r'ExtResource\("([^"]+)"\)', text)) <= ext_ids
                assert set(re.findall(r'SubResource\("([^"]+)"\)', text)) <= sub_ids
                assert len(re.findall(r'\[node ', text)) >= 1
                match = re.search(r'load_steps=(\d+)', text)
                assert int(match[1]) == len(ext_ids) + len(sub_ids) + 1
            checked += 1
        elif file.suffix == '.svg':
            ET.parse(file)

for project in projects:
    text = project.read_text(encoding='utf-8')
    for action in ['move_left', 'move_right', 'jump', 'restart']:
        assert f'{action}=' in text
    world = (project.parent / 'scenes/world.tscn').read_text(encoding='utf-8')
    assert 'name="HUD"' in world and 'name="Score"' in world

# Analytical feasibility only, not a simulation of Godot's collision solver.
g, speed, jump, step_height = 1400.0, 240.0, 560.0, 96.0
max_height = jump * jump / (2 * g)
assert max_height > step_height
time_to_upper_landing = (jump + math.sqrt(jump*jump-2*g*step_height)) / g
reach = speed * time_to_upper_landing
assert reach > 40 + 36, 'Gap plus conservative body clearance must be reachable'
final = root / '04_coin'
assert 'groups=["player"]' in (final/'scenes/player.tscn').read_text()
assert 'groups=["coins"]' in (final/'scenes/coin.tscn').read_text()
print(f'PASS: {len(projects)} projects, {checked} text resources, references and SVG XML')
print(f'Analytical jump height: {max_height:.1f}px; step: {step_height:.1f}px; reach to upper landing: {reach:.1f}px')
print('Godot parsing, rendering, input and collision behaviour require an engine run.')

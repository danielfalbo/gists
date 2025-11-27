# pip install Pillow

from PIL import Image, ImageDraw
import math

w = 3000
h = 3000
thickness = 25
padding = 300

black = (0, 0, 0)
white = (255, 255, 255)

img = Image.new('RGB', (w, h), black)
draw = ImageDraw.Draw(img)

cx = w // 2
cy = h // 2
radius = (w // 2) - padding 

bbox = [padding, padding,w - padding, h - padding]

draw.ellipse(bbox, outline=white, width=thickness)

x = int(cx - radius + (1/3 * 2 * radius))

dx = x - cx
dy = math.sqrt(radius**2 - dx**2) - thickness // 2

y1 = int(cy - dy)
y2 = int(cy + dy)

draw.line([(x, y1), (x, y2)], fill=white, width=thickness)

file_name = 'out.png'
img.save(file_name)
print(f"Image saved as {file_name}")

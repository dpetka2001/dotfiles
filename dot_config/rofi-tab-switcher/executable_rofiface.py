#!/usr/bin/python3 -u

import json
import sys
import struct
import subprocess
# import pprint
import random
from xml.sax.saxutils import escape

### JSON I/O for Firefox FFI from Mozilla websites
# Read a message from stdin and decode it.
def get_message():
    raw_length = sys.stdin.buffer.read(4)
    if not raw_length:
        sys.exit(0)
    message_length = struct.unpack('=I', raw_length)[0]
    message = sys.stdin.buffer.read(message_length)
    return json.loads(message)


# Encode a message for transmission, given its content.
def encode_message(message_content):
    encoded_content = json.dumps(message_content)
    encoded_length = struct.pack('=I', len(encoded_content))
    return {'length': encoded_length, 'content': encoded_content}


# Send an encoded message to stdout.
def send_message(encoded_message):
    sys.stdout.buffer.write(encoded_message['length'])
    sys.stdout.write(encoded_message['content'])
    sys.stdout.flush()


### list of CSS colors; each window will get assigned a random one of these, picked the first time it is observed
colors = ["AliceBlue","AntiqueWhite","Aqua","Aquamarine","Azure","Beige","Bisque","BlanchedAlmond","Blue","BlueViolet","Brown","BurlyWood","CadetBlue","Chartreuse","Chocolate","Coral","CornflowerBlue","Cornsilk","Crimson","Cyan","DarkBlue","DarkCyan","DarkGoldenRod","DarkGray","DarkGrey","DarkGreen","DarkKhaki","DarkMagenta","DarkOliveGreen","Darkorange","DarkOrchid","DarkRed","DarkSalmon","DarkSeaGreen","DarkSlateBlue","DarkSlateGray","DarkSlateGrey","DarkTurquoise","DarkViolet","DeepPink","DeepSkyBlue","DimGray","DimGrey","DodgerBlue","FireBrick","FloralWhite","ForestGreen","Fuchsia","Gainsboro","GhostWhite","Gold","GoldenRod","Gray","Grey","Green","GreenYellow","HoneyDew","HotPink","IndianRed","Indigo","Ivory","Khaki","Lavender","LavenderBlush","LawnGreen","LemonChiffon","LightBlue","LightCoral","LightCyan","LightGoldenRodYellow","LightGray","LightGrey","LightGreen","LightPink","LightSalmon","LightSeaGreen","LightSkyBlue","LightSlateGray","LightSlateGrey","LightSteelBlue","LightYellow","Lime","LimeGreen","Linen","Magenta","Maroon","MediumAquaMarine","MediumBlue","MediumOrchid","MediumPurple","MediumSeaGreen","MediumSlateBlue","MediumSpringGreen","MediumTurquoise","MediumVioletRed","MidnightBlue","MintCream","MistyRose","Moccasin","NavajoWhite","Navy","OldLace","Olive","OliveDrab","Orange","OrangeRed","Orchid","PaleGoldenRod","PaleGreen","PaleTurquoise","PaleVioletRed","PapayaWhip","PeachPuff","Peru","Pink","Plum","PowderBlue","Purple","Red","RosyBrown","RoyalBlue","SaddleBrown","Salmon","SandyBrown","SeaGreen","SeaShell","Sienna","Silver","SkyBlue","SlateBlue","SlateGray","SlateGrey","Snow","SpringGreen","SteelBlue","Tan","Teal","Thistle","Tomato","Turquoise","Violet","Wheat","Yellow","YellowGreen"]

colorsj = ["#F08F90","#F47983","#DB5A6B","#C93756","#FCC9B9","#FFB3A7","#F2666C","#F58F84","#AC8181","#B95754","#C91F37","#9D2933","#7B3B3A","#F7665A","#B56C60","#97645A","#A24F46","#C3272B","#8F1D21","#672422","#BC2D29","#5E2824","#8B352D","#FA7B62","#F8674F","#DC3023","#AB4C3D","#934337","#9D2B22","#913228","#6F3028","#351E1C","#F35336","#D34E36","#CF3A24","#A13D2D","#913225","#752E23","#F9906F","#FF7952","#F07F5E","#E68364","#FF4E20","#E35C38","#CB6649","#B35C44","#B14A30","#9B533F","#8C4736","#60281E","#542D24","#4C221B","#ff3500","#9F7462","#B64925","#592B1F","#351F19","#F57F4F","#EC8254","#9F5233","#EC956C","#985538","#824B35","#FFA26B","#FCA474","#FF8936","#FA9258","#FB8136","#8F583C","#2E211B","#AB6134","#CA6924","#FFA565","#D57835","#C66B27","#A96232","#985629","#8C5939","#6A432D","#593A27","#C48E69","#BE7F51","#7D4E2D","#B7702D","#6B4423","#DB8449","#F7BB7D","#FFA400","#FFA631","#E08A1E","#CB7E1F","#C57F2E","#785E49","#FFB95A","#FAA945","#CE9F6F","#BB8141","#FFB61E","#FFB94E","#E2BE9F","#E69B3A","#E29C45","#B0927A","#826B58","#7F6B5D","#7F5D3B","#665343","#4C3D30","#A17917","#896C39","#5C4827","#E3B130","#E2B13C","#F3C13A","#D3B17D","#AA8736","#957B38","#D9B611","#645530","#BDA928","#BBA46D","#9C8A4D","#534A32","#473F2D","#8B7D3A","#524B2A","#3B3429","#857C55","#5E5545","#7A942E","#4D4B3A","#BCB58C","#8DB255","#8C9E5E","#5B8930","#52593B","#454D32","#8C9C76","#6B9362","#817B69","#5E644F","#374231","#2A603B","#A5BA93","#898A74","#407A52","#3D5D42","#3D4035","#006442","#656255","#224634","#2D4436","#2E372E","#5A6457","#749F8D","#819C8B","#3A6960","#3A403B","#2B3733","#354E4B","#203838","#757D75","#4F4944","#2B3736","#86ABA5","#6A7F7A","#C6C2B6","#48929B","#006C7F","#455859","#5C544E","#264348","#364141","#1D697C","#317589","#4D646C","#044F67","#344D56","#3D4C51","#4D8FAC","#252321","#5D8CAE","#192236","#181B26","#1F4788","#003171","#1B294B","#78779B","#191F45","#766980","#5A4F74","#89729E","#614E6E","#875F9A","#5D3F6A","#976E9A","#3F313A","#2B2028","#3A243B","#A87CA0","#8D608C","#5B3256","#4F284B","#23191E","#763568","#BB7796","#491E3C","#755D5B","#63424B","#6D2B50","#4D3B3C","#A4345D","#8F4155","#43242A","#512C31","#7E2639","#59292C","#44312E","#FFDDCA","#B9A193","#97867C","#6E5F57","#4B3C39","#393432","#352925","#27221F","#171412","#EBF6F7"]

colormap = {}

def get_color(id):
    if not id in colormap:
        colormap[id] = random.choice(colors)
    return colormap[id]

### main loop
while True:
    message = get_message()
    
    # spawn rofi and get selection
    rofi = subprocess.Popen("rofi -dmenu -i -scroll-method 1 -format i -p 'Go to tab' -markup-rows -no-custom -selected-row %d|head -n 1"%(message['active']), shell=True, stdin=subprocess.PIPE, stdout=subprocess.PIPE)
    out,err = rofi.communicate(u''.join(map(lambda tab:u"<span color='%s'>(%d)</span>\t%s <span alpha='50%%'>%s</span>\n"%(get_color(tab['window']),tab['window'],escape(tab['title']),escape(tab['url'])),message['tabs'])).encode('utf-8'))
    
    # if anything was selected, tell browser side to switch to that tab
    if out != b'':
        send_message(encode_message(message['tabs'][int(out)]['id']))



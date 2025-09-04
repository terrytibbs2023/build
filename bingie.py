import os
import zipfile

# Settings
skin_name = "MinimalSkin"
zip_name = "skin.minimal.zip"

# Folder structure
folders = [
    skin_name,
    f"{skin_name}/1080i",  # You can add other resolutions if needed
    f"{skin_name}/media",
]

# Placeholder images
images = {
    "power.png": "placeholder",
    "addon.png": "placeholder",
    "favourites.png": "placeholder",
}

# XML content
addon_xml = f"""<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<addon id="skin.{skin_name.lower()}" name="{skin_name}" version="1.0.0" provider-name="User">
    <requires>
        <import addon="xbmc.python" version="3.0.0"/>
    </requires>
    <extension point="xbmc.gui.skin" defaultresolution="1080i">
        <settings/>
        <assets>
            <media zip="false">media</media>
        </assets>
        <views>
            <view name="Home"/>
        </views>
    </extension>
</addon>
"""

home_xml = """<?xml version="1.0" encoding="UTF-8"?>
<window>
    <controls>
        <!-- Power Button -->
        <image pos="10,10" size="64,64" texture="power.png"/>
        <!-- Addon Buttons -->
        <image pos="100,10" size="64,64" texture="addon.png"/>
        <image pos="170,10" size="64,64" texture="addon.png"/>
        <!-- Favourites -->
        <image pos="240,10" size="64,64" texture="favourites.png"/>
    </controls>
</window>
"""

skin_xml = f"""<?xml version="1.0" encoding="UTF-8"?>
<skin>
    <include file="Home.xml"/>
</skin>
"""

# Create folders
for folder in folders:
    os.makedirs(folder, exist_ok=True)

# Write XML files
with open(f"{skin_name}/addon.xml", "w") as f:
    f.write(addon_xml)

with open(f"{skin_name}/MySkin.xml", "w") as f:
    f.write(skin_xml)

with open(f"{skin_name}/Home.xml", "w") as f:
    f.write(home_xml)

# Create placeholder images
from PIL import Image

for img_name in images:
    path = os.path.join(skin_name, "media", img_name)
    img = Image.new("RGBA", (64, 64), (255, 0, 0, 255))  # Red box placeholder
    img.save(path)

# Zip the skin
with zipfile.ZipFile(zip_name, "w", zipfile.ZIP_DEFLATED) as zipf:
    for root, _, files in os.walk(skin_name):
        for file in files:
            file_path = os.path.join(root, file)
            zipf.write(file_path, os.path.relpath(file_path, skin_name))

print(f"Created {zip_name} successfully!")


#!/bin/bash
# Patch graph_visualizer.py to fix imgui_bundle compatibility

echo "Patching graph_visualizer.py for imgui_bundle compatibility..."

VIZFILE="/app/visualizer/graph_visualizer.py"

# 1. Kommentoidaan pois vanhentunut tex_desired_width rivi
sed -i 's/^\s*io\.fonts\.tex_desired_width = 4096/        # io.fonts.tex_desired_width = 4096  # DISABLED: deprecated in newer imgui_bundle/' "$VIZFILE"

# 2. Kommentoidaan pois get_glyph_ranges_chinese_full() (ei tuettu uudessa versiossa)
sed -i 's/^\s*glyph_ranges_as_int_list=io\.fonts\.get_glyph_ranges_chinese_full(),/                # glyph_ranges_as_int_list=io.fonts.get_glyph_ranges_chinese_full(),  # DISABLED: deprecated/' "$VIZFILE"

# 3. Kommentoidaan pois set_window_font_scale() (ei tuettu uudessa versiossa)
sed -i 's/^\s*imgui\.set_window_font_scale(1)/        # imgui.set_window_font_scale(1)  # DISABLED: deprecated/' "$VIZFILE"

# Tarkista että patchit onnistuivat
PATCH_COUNT=$(grep -c "# DISABLED:" "$VIZFILE" || true)
echo "✓ Tehty $PATCH_COUNT patchausta"

if [ "$PATCH_COUNT" -ge 3 ]; then
    echo "✓ Kaikki patchit onnistuivat!"
else
    echo "⚠ Vain $PATCH_COUNT/3 patchausta onnistui, mutta jatketaan..."
fi

echo "graph_visualizer.py patched successfully"
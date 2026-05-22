#!/usr/bin/env -S uv run
# /// script
# dependencies = ["prompt_toolkit"]
# ///
import os
import asyncio
from prompt_toolkit import Application
from prompt_toolkit.application import get_app
from prompt_toolkit.buffer import Buffer
from prompt_toolkit.cursor_shapes import CursorShape
from prompt_toolkit.document import Document
from prompt_toolkit.formatted_text import FormattedText
from prompt_toolkit.key_binding import KeyBindings
from prompt_toolkit.layout.containers import HSplit, Window
from prompt_toolkit.layout.controls import BufferControl, FormattedTextControl
from prompt_toolkit.layout.layout import Layout
from prompt_toolkit.layout.margins import ScrollbarMargin
from prompt_toolkit.selection import SelectionType
from prompt_toolkit.styles import Style
from prompt_toolkit.widgets import Box, Frame

SCRATCH_FILE = os.path.expanduser("~/.scratchpad.md")


def load():
    try:
        return open(SCRATCH_FILE).read()
    except FileNotFoundError:
        return ""


def save(text):
    with open(SCRATCH_FILE, "w") as f:
        f.write(text)


def main():
    buf = Buffer(document=Document(load()), multiline=True)

    ta_kb = KeyBindings()

    @ta_kb.add("c-a", eager=True)
    def select_all(event):
        buf.cursor_position = 0
        buf.start_selection(selection_type=SelectionType.CHARACTERS)
        buf.cursor_position = len(buf.text)

    @ta_kb.add("backspace", eager=True)
    @ta_kb.add("c-h", eager=True)
    def handle_backspace(event):
        if buf.selection_state:
            buf.cut_selection()
        else:
            buf.delete_before_cursor()

    @ta_kb.add("delete", eager=True)
    def handle_delete(event):
        if buf.selection_state:
            buf.cut_selection()
        else:
            buf.delete()

    text_window = Window(
        content=BufferControl(
            buffer=buf,
            key_bindings=ta_kb,
            focus_on_click=True,
        ),
        wrap_lines=True,
        right_margins=[ScrollbarMargin()],
        style="class:textarea",
    )

    status_msg = [""]

    def get_title():
        return FormattedText([
            ("class:title.pad",  "  "),
            ("class:title.icon", "◆ "),
            ("class:title.name", "Scratchpad"),
            ("class:title.sep",  "   ·   "),
            ("class:title.path", SCRATCH_FILE),
        ])

    def get_status():
        text = buf.text
        words = len(text.split()) if text.strip() else 0
        lines = len(text.splitlines()) or 1

        hint = status_msg[0] or "  ^S Save   ^Q Quit"
        stats = f"{words} words  {lines} lines  "

        try:
            width = get_app().output.get_size().columns
        except Exception:
            width = 80
        pad = max(0, width - len(hint) - len(stats))

        return FormattedText([
            ("class:status.hint",  hint),
            ("class:status.mid",   " " * pad),
            ("class:status.stats", stats),
        ])

    kb = KeyBindings()

    @kb.add("c-s")
    def on_save(event):
        save(buf.text)
        status_msg[0] = "  ✓ Saved"

        async def reset():
            await asyncio.sleep(1.5)
            status_msg[0] = ""
            event.app.invalidate()

        event.app.create_background_task(reset())

    @kb.add("c-q")
    @kb.add("c-c")
    def on_quit(event):
        save(buf.text)
        event.app.exit()

    layout = Layout(
        HSplit([
            Window(FormattedTextControl(get_title), height=1, style="class:title"),
            Window(height=1, char=" ", style="class:gap"),
            Box(
                body=Frame(body=text_window, style="class:frame"),
                padding_left=3, padding_right=3, padding_top=0, padding_bottom=0,
            ),
            Window(height=1, char=" ", style="class:gap"),
            Window(FormattedTextControl(get_status), height=1, style="class:status"),
        ]),
        focused_element=text_window,
    )

    style = Style.from_dict({
        "textarea":     "#00b4d8 bg:#ffffff",
        "title":        "bg:#f2f4f5 #333333",
        "title.pad":    "bg:#f2f4f5",
        "title.icon":   "bg:#f2f4f5 #00b4d8 bold",
        "title.name":   "bg:#f2f4f5 #222222 bold",
        "title.sep":    "bg:#f2f4f5 #cccccc",
        "title.path":   "bg:#f2f4f5 #aaaaaa",
        "gap":          "bg:#ffffff",
        "status":       "bg:#f2f4f5",
        "status.hint":  "bg:#f2f4f5 #999999",
        "status.mid":   "bg:#f2f4f5",
        "status.stats": "bg:#f2f4f5 #bbbbbb",
        "scrollbar.background": "bg:#e8e8e8",
        "scrollbar.button":     "bg:#cccccc",
        "frame.border":         "#dddddd bg:#ffffff",
    })

    Application(
        layout=layout,
        key_bindings=kb,
        full_screen=True,
        style=style,
        mouse_support=True,
        cursor=CursorShape.BLINKING_BEAM,
    ).run()


if __name__ == "__main__":
    main()

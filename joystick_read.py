#!/usr/bin/env python3
import argparse
import sys
import time
import pygame

def list_joysticks():
    pygame.joystick.quit()
    pygame.joystick.init()
    n = pygame.joystick.get_count()
    for i in range(n):
        j = pygame.joystick.Joystick(i)
        j.init()
        print(f"[{i}] {j.get_name()} (axes={j.get_numaxes()}, buttons={j.get_numbuttons()}, hats={j.get_numhats()})")

def main():
    parser = argparse.ArgumentParser(description="Read USB joystick/gamepad and print events.")
    parser.add_argument("--index", type=int, default=0, help="Joystick index (see list). Default: 0")
    parser.add_argument("--deadzone", type=float, default=0.05, help="Axis deadzone (0..1). Default: 0.05")
    parser.add_argument("--list", action="store_true", help="List connected joysticks and exit")
    args = parser.parse_args()

    pygame.init()
    pygame.joystick.init()

    if args.list:
        if pygame.joystick.get_count() == 0:
            print("No joysticks found.")
        else:
            list_joysticks()
        return

    if pygame.joystick.get_count() == 0:
        print("No joysticks detected. Try plugging it in and run with --list.")
        sys.exit(1)

    if args.index < 0 or args.index >= pygame.joystick.get_count():
        print(f"Invalid index {args.index}. Available:")
        list_joysticks()
        sys.exit(1)

    js = pygame.joystick.Joystick(args.index)
    js.init()
    name = js.get_name()
    print(f"Opened joystick [{args.index}]: {name}")
    print(f"Axes={js.get_numaxes()}, Buttons={js.get_numbuttons()}, Hats={js.get_numhats()}")
    print("Press Ctrl+C to quit.\n")

    # Cache last-reported values to emit only on change
    last_axes = [None] * js.get_numaxes()
    last_buttons = [None] * js.get_numbuttons()
    last_hats = [None] * js.get_numhats()

    clock = pygame.time.Clock()
    try:
        while True:
            # Pump SDL events so the OS updates device state
            pygame.event.pump()
            t = time.time()

            # Axes
            axs=[]
            for a in range(js.get_numaxes()):
                val = js.get_axis(a)
                # Apply deadzone (snap small values to 0)
                if abs(val) < args.deadzone:
                    val = 0.0
                # Round for stable printing
                val_r = round(val, 4)
                axs.append(val_r)
            print(f"{t:.3f} AXIS ", axs)

            # Buttons (0 or 1)
            bts=[]
            for b in range(js.get_numbuttons()):
                state = js.get_button(b)
                bts.append(state)
            print(f"{t:.3f} BUTTON ", bts)

            # Hats (D-pad) as (x,y) with x,y in {-1,0,1}
            hats=[]
            for h in range(js.get_numhats()):
                pos = js.get_hat(h)  # tuple (x,y)
                hats.append(pos)
            print(f"{t:.3f} HAT {hats}")

            # Limit CPU usage; adjust if you want faster prints
            clock.tick(10) #hz
    except KeyboardInterrupt:
        print("\nExiting.")
    finally:
        js.quit()
        pygame.quit()

if __name__ == "__main__":
    main()


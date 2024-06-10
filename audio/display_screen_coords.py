import os, sys, time
import ait

def main():
    while True:
        x, y = ait.mouse()
        cls()
        move_cursor(0, 0)
        print('x: ' + str(x) + ' y: ' + str(y))
        time.sleep(0.05)


if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        print('Interrupted')
        try:
            sys.exit(130)
        except SystemExit:
            os._exit(130)
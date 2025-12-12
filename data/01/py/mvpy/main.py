from config import SAMPLE_INPUTS, SAMPLE_OUTPUTS
from moviepy.editor import *
from PIL import Image

def Directories():
    source = "outputs/thumbnails_per_frame"

    count = 0
    dir = []

    for i in os.listdir(source):
        dir.insert(count, int(i))
        count += 1

    dir.sort()
    count = 0

    for i in dir:
        count += 1
        if int(i) != count:
            os.rename(source + "/" + str(i), source + "/" + str(count))

    return count

def Main():
    count = Directories()
    while len(os.listdir("inputs")) != 0:
        clip_list = os.listdir("inputs")
        clips = clip_list[0]
        count+=1
        source_path = os.path.join(SAMPLE_INPUTS, clips)
        thumbnail_per_frame = os.path.join(SAMPLE_OUTPUTS, f"thumbnails_per_frame/{count}")
        os.makedirs(thumbnail_per_frame, exist_ok=True)

    #    thumbnail_per_sec = os.path.join(SAMPLE_OUTPUTS, f"thumbnails_per_second/{count}")
    #    os.makedirs(thumbnail_per_sec, exist_ok=True)

        clip = VideoFileClip(source_path)

        print("=" * 10)
        print(clip.reader.fps)
        print(clip.reader.nframes)
        print(clip.duration)
        print(f"Dirname >> {count}")
        print(f"Source >> {source_path}")
        print("=" * 10)

        c=0
        for i, frame in enumerate(clip.iter_frames()):
            new_img_path = os.path.join(thumbnail_per_frame, f"zzz{i}.jpg")
            new_img = Image.fromarray(frame)
            new_img.save(new_img_path)
            c+=1
            print(f"{c}/{clip.reader.nframes}", end='\r')
        print(f"{c}/{clip.reader.nframes}")

        os.rename(source_path, "outputs/thumbnails_per_frame/" + str(count) + "/" + os.path.basename(source_path))
Main()

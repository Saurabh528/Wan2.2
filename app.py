from fastapi import FastAPI, UploadFile, Form
import subprocess

app = FastAPI()

@app.post("/s2v")
async def speech_to_video(prompt: str = Form(...), image: UploadFile = None, audio: UploadFile = None):
    image_path = "examples/i2v_input.JPG"
    audio_path = "examples/talk.wav"

    if image:
        image_path = f"./{image.filename}"
        with open(image_path, "wb") as f:
            f.write(await image.read())

    if audio:
        audio_path = f"./{audio.filename}"
        with open(audio_path, "wb") as f:
            f.write(await audio.read())

    cmd = [
        "python3", "generate.py",
        "--task", "s2v-14B",
        "--size", "1024*704",
        "--ckpt_dir", "./Wan2.2-S2V-14B",
        "--offload_model", "True",
        "--convert_model_dtype",
        "--prompt", prompt,
        "--image", image_path,
        "--audio", audio_path
    ]
    subprocess.run(cmd)

    return {"status": "done", "output": "video saved in output folder"}

import logging
from functools import partial
from pathlib import Path
from tqdm import tqdm
from piper_speaker import Piper
import soundfile as sf
import os

_FILE = Path(__file__)
_DIR = _FILE.parent
_LOGGER = logging.getLogger(_FILE.stem)
model = None
synthesize = None

def load_model():
    global synthesize
    if synthesize:
        return synthesize
    model = 'C:/Users/LENOVO_User/AppData/Roaming/nvda/piper/voices/v1.0/es-sharvard-medium/es-sharvard-medium.onnx'
    speaker_id = 1
    voice = Piper(model)
    synthesize = partial(
        voice.synthesize,
        speaker_id=speaker_id,
        length_scale=None,
        noise_scale=0.667,
        noise_w=0.8,
    )
    return synthesize


my_model = load_model()
speakers_folder = _DIR.parent / "speakers/es/f1"
if not speakers_folder.exists():
    os.makedirs(speakers_folder)

for i in tqdm(range(100), desc="Converting 0 to 99..."):
    audio_norm, sample_rate = synthesize(str(i))
    sf.write(str(speakers_folder / f"{i}.wav"), audio_norm, sample_rate)

# 100, 200, 300, 400, 500, etc.
for i in tqdm(range(100, 1001, 100), desc="Converting 100, 200, 300..."):
    audio_norm, sample_rate = synthesize(str(i))
    sf.write(str(speakers_folder / f"{i}.wav"), audio_norm, sample_rate)

big_numbers = [1000, "millón", "millones", "+", "menos", "multiplicado por", "Dividido por", "%", "Abrir paréntesis", "Cerrar paréntesis", "Coma", "punto.", "="]
for num in tqdm(big_numbers, desc="Converting big numbers..."):
    audio_norm, sample_rate = synthesize(str(num))
    if isinstance(num, int):
        sf.write(str(speakers_folder / f"{num}.wav"), audio_norm, sample_rate)
    else:
        sf.write(str(speakers_folder / f"{num.lower()}.wav"), audio_norm, sample_rate)

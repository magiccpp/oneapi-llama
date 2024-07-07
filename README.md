docker build -t magiccpp1/oneapi-llama-server-image .

docker build -t llama-server-image .

docker run -p 8000:8000 -v /home/ken/models/:/models  -e MODEL_PATH="/models/Meta-Llama-3-8B-Instruct.Q8_0.gguf" -e HOST="0.0.0.0" -e PORT="8000" magiccpp1/oneapi-llama-server-image:latest


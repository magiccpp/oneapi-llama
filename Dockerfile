# Use intel/oneapi-basekit as the base image
FROM intel/oneapi-basekit

# Install git
RUN apt-get update && apt-get install -y git

# Clone the llama.cpp repository
RUN git clone https://github.com/ggerganov/llama.cpp.git

# Set the working directory
WORKDIR /llama.cpp

# Build the llama.cpp
RUN cmake -B build_intel -DGGML_BLAS=ON -DGGML_BLAS_VENDOR=Intel10_64lp -DCMAKE_C_COMPILER=icx -DCMAKE_CXX_COMPILER=icpx -DGGML_NATIVE=ON
RUN cmake --build build_intel

# Set default environment variables (you can override them when running the container)
ENV HOST="0.0.0.0"
ENV PORT="8000"

# Expose port 8000 for the llama-server
EXPOSE $PORT

# Command to run llama-server during run-time
CMD ["sh", "-c", "./build_intel/bin/llama-server -m $MODEL_PATH --host $HOST --port $PORT"]

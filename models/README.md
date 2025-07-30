# Models Directory

This directory is where you should place your GGUF model files for the Kolosal Server.

## Adding Models

1. **Download GGUF Models**: Download your preferred GGUF format models and place them in this directory.

2. **Model Loading**: The Kolosal Server will automatically detect and load models from this directory. You can configure specific model parameters through the Kolosal Server API or dashboard interface.

## Popular Model Sources

- **Hugging Face**: Search for GGUF format models
- **Ollama Models**: Many models are available in GGUF format
- **LlamaFile**: Pre-quantized models

## Model Size Considerations

- **7B models**: ~4-8GB RAM required
- **13B models**: ~8-16GB RAM required  
- **70B models**: ~40-80GB RAM required

## GPU Acceleration

To use GPU acceleration, set `n_gpu_layers` to the number of layers you want to offload to GPU. Start with a low number and increase based on your GPU memory.

## Example Models Directory Structure

```
models/
├── llama-2-7b-chat.q4_0.gguf
├── mistral-7b-instruct.q4_0.gguf
└── codellama-7b-instruct.q4_0.gguf
```

**Note**: Model files are not included in the repository due to their large size. You need to download them separately.

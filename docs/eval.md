# Eval

How we know the doctor helps. Nothing here has been run yet, and no score in this file is a result.

## The claim

On repos that fail on an older Mac today, an agent with MAC reaches the repo's own success check after clean replay more often than the same agent without it, and it never says "fixed" when it is not.

## Frozen set

30 GitHub repos that fail on the first host today, frozen at a commit or release in [issue #2](https://github.com/Troy-LL/make-anything-compatible/issues/2):

| Slice | Count | What fails |
| --- | --- | --- |
| Python ML | 10 | Wheels that stop at an older macOS or x86_64 line, Metal or MLX only paths, CUDA only packages |
| Native | 10 | Swift and Xcode SDK caps, C and C++ projects whose Metal backend fails on Intel GPUs |
| Node, Go, Rust CLIs | 10 | Release assets that ship arm64 only, or need macOS 14 or later |

Each row records the repo, the ref, the slice, what fails, an evidence link, the expected verdict, and the success check. A "fails today" claim is confirmed on the host before the row is frozen, or the row is marked unconfirmed.

### Seed candidates

These come from earlier research, checked on 15 Nov 2026 (Asia/Manila). They are candidates, not the frozen set. None was installed on the host in that research. Expected verdicts are inferences from each project's own docs, releases, or issues.

| Repo | Candidate slice | Expected verdict | Evidence |
| --- | --- | --- | --- |
| [pytorch/pytorch](https://github.com/pytorch/pytorch) | Python ML | Fix: pin `torch==2.2.2` | [Deprecation notice](https://dev-discuss.pytorch.org/t/pytorch-macos-x86-builds-deprecation-starting-january-2024/1690) |
| [tensorflow/tensorflow](https://github.com/tensorflow/tensorflow) | Python ML | Fix: pin `tensorflow==2.16.2` | [v2.16.1 notes](https://github.com/tensorflow/tensorflow/releases/tag/v2.16.1) |
| `microsoft/onnxruntime` (no link while it 404s) | Python ML | Fix: pin `onnxruntime==1.23.2` | [PyPI files](https://pypi.org/project/onnxruntime/#files): 1.23.2 is the last release with `macosx_13_0_x86_64` wheels. See the note below |
| [jax-ml/jax](https://github.com/jax-ml/jax) | Python ML | Fix: pin `jax` and `jaxlib` 0.4.38 | [v0.5.0 notes](https://github.com/jax-ml/jax/releases/tag/jax-v0.5.0) |
| [faiss-wheels/faiss-wheels](https://github.com/faiss-wheels/faiss-wheels) | Python ML | Fix: pin `faiss-cpu==1.12.0` | [1.12.0 files](https://pypi.org/project/faiss-cpu/1.12.0/#files) (`macosx_13_0_x86_64`). [Issue #126](https://github.com/faiss-wheels/faiss-wheels/issues/126) covers 1.11.0 needing macOS 14 |
| [Comfy-Org/ComfyUI](https://github.com/Comfy-Org/ComfyUI) | Python ML | Fix: torch pin and `--cpu` | [issue #3096](https://github.com/Comfy-Org/ComfyUI/issues/3096) |
| [AUTOMATIC1111/stable-diffusion-webui](https://github.com/AUTOMATIC1111/stable-diffusion-webui) | Python ML | Fix: Intel Mac torch pin, CPU | [PR #15851](https://github.com/AUTOMATIC1111/stable-diffusion-webui/pull/15851) |
| [oobabooga/textgen](https://github.com/oobabooga/textgen) | Python ML | Fix: torch 2.2.2 first | [issue #6444](https://github.com/oobabooga/textgen/issues/6444) |
| [abetlen/llama-cpp-python](https://github.com/abetlen/llama-cpp-python) | Python ML | Fix: CPU-only source build | [issue #1988](https://github.com/abetlen/llama-cpp-python/issues/1988) |
| [ml-explore/mlx](https://github.com/ml-explore/mlx) | Python ML | Wall | [Install docs](https://ml-explore.github.io/mlx/build/html/install.html) |
| [ml-explore/mlx-lm](https://github.com/ml-explore/mlx-lm) | Python ML | Wall | [README](https://github.com/ml-explore/mlx-lm) |
| [bitsandbytes-foundation/bitsandbytes](https://github.com/bitsandbytes-foundation/bitsandbytes) | Python ML | Wall | [README](https://github.com/bitsandbytes-foundation/bitsandbytes/blob/main/README.md) |
| [vllm-project/vllm](https://github.com/vllm-project/vllm) | Python ML | Wall natively | [issue #17212](https://github.com/vllm-project/vllm/issues/17212) |
| [Dao-AILab/flash-attention](https://github.com/Dao-AILab/flash-attention) | Python ML | Wall | [README requirements](https://github.com/Dao-AILab/flash-attention) (CUDA or ROCm, Linux). [Issue #873](https://github.com/Dao-AILab/flash-attention/issues/873) is weak evidence: a generic `CUDA_HOME` install error |
| [triton-lang/triton](https://github.com/triton-lang/triton) | Python ML | Wall | [issue #1465](https://github.com/triton-lang/triton/issues/1465) |
| [unslothai/unsloth](https://github.com/unslothai/unsloth) | Python ML | Wall for training | [issue #5046](https://github.com/unslothai/unsloth/issues/5046) |
| [ggml-org/llama.cpp](https://github.com/ggml-org/llama.cpp) | Native | Fix: no GPU offload, Metal off | [issue #4004](https://github.com/ggml-org/llama.cpp/issues/4004) |
| [ggml-org/whisper.cpp](https://github.com/ggml-org/whisper.cpp) | Native | Fix: Metal off | [issue #1292](https://github.com/ggml-org/whisper.cpp/issues/1292) |
| [argmaxinc/argmax-oss-swift](https://github.com/argmaxinc/argmax-oss-swift) | Native | Wall for the documented path | [README](https://github.com/argmaxinc/argmax-oss-swift) |
| [janhq/jan](https://github.com/janhq/jan) | Native | Fix: stay on v0.8.4 for local models | [Install docs](https://docs.jan.ai/desktop/install/mac) |
| [ollama/ollama](https://github.com/ollama/ollama) | Go | Fix: stay on v0.12.4, block auto-update | [issue #12572](https://github.com/ollama/ollama/issues/12572) |
| [mudler/LocalAI](https://github.com/mudler/LocalAI) | Go | Wall natively. Maybe a container | [PR #7616](https://github.com/mudler/LocalAI/pull/7616) |


ONNX Runtime note: the GitHub repo returns 404. A [third-party report](https://techmeasured.com/repos/microsoft-onnx-runtime-github-repo-404-ci-builds-break-nuget-pypi-still-work-what-to-do) says Microsoft made it private around Nov 18, 2026 (Asia/Manila). We found no Microsoft statement. If that report is right, the repo was made private, not moved. The PyPI files are still there, so the row stays, and issue #2 confirms the repo is reachable before freezing it.

Two more from that research are host checks, not repos: Xcode (stay on 15.2) and LM Studio (closed app, Intel not supported). They stay out of the frozen set.

### Gaps

- The Python ML slice has more candidates than slots. Issue #2 picks 10 and records how.
- The native slice has four candidates for ten slots. It needs Swift and Xcode SDK projects.
- The Node, Go, and Rust slice has two Go candidates and no Node or Rust rows. Nothing has been researched for it yet. Rows get added only with an evidence link.
- The earlier research had about 15 fixable rows and 10 walls. The frozen set should keep both kinds, so a tool that always says "fixed" or always says "no" scores badly.

## Baseline

A plain coding agent with no MAC scaffolding, on the same host, with one stated agent and model. Every repo gets the same prompt: get the README demo or the tests running on this Mac, or say that you cannot. Its commands are logged so they can be replayed.

## Scoring

Each row is scored twice:

| Score | Counts |
| --- | --- |
| Reached | The success check passes after a clean replay of the recorded steps |
| Honest | An expected wall was declared a wall, and no row was called fixed when its replay failed |

A row the agent calls fixed that fails replay is a false fix. A false fix is worse than an honest no, and it is reported on its own line.

## Gold command

Planned. One script reruns the frozen set and rebuilds the score table from the logs:

```text
# Planned
bash evals/run.sh --set evals/frozen.json --agent <name> --model <name>
```

Scoring the same logs twice must give the same table.

## Classifier accuracy

Before any install, `compat check` is scored against the expected verdicts. If it is wrong on more than 1 in 5 rows, stop and rescope before building replay.

## Cost and time

The spend cap and per-repo time limit are set in issue #2 before the first paid run. Not set yet.

## Proof

Numbers go in the README only after a run is committed with its scripts and logs.

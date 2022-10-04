from setuptools import setup, find_packages

setup(
    name="srfbn_cvpr19",
    version="0.1",
    packages=find_packages(),
    install_requires=[
        "scikit-image",
        "imageio",
        "torch",
        "tqdm",
        "pandas",
        "opencv-python",
        "matlabengine",
        "wandb==0.12.15",
    ],
)

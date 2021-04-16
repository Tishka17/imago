import imagopy

print(f"{imagopy.get_version()=}")

imago = imagopy.Imago()
imago.load_image_from_file('setup.py')
imago.recognize()
imago.save_mol_to_file('molecule.mol')

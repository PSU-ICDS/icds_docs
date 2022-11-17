import random



def make_sample(filename):
	number_sequences = 5
	lines_per_seq = 3
	nt_per_line = 80
	nucleotides = ['A', 'G', 'C', 'T']

	with open(filename, 'w+') as f:
                        f.write('')

	for i in range(1, number_sequences + 1):
		s='>SEQUENCE_%d\n' %i
		for j in range(lines_per_seq):
			for k in range(nt_per_line):
				s = s + nucleotides[random.randint(0, 3)]
			s = s + '\n'
		print(s)
		with open(filename, 'a+') as f:
			f.write(s)
		

if __name__ == '__main__':
	make_sample('sample.fa')
	print('done')

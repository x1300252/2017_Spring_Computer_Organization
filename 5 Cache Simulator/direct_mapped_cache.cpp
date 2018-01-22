/*
	Computer Organization Lab 5
	0416038王詠萱 0416326梁靖敏
*/
#include <iostream>
#include <stdio.h>
#include <math.h>

using namespace std;

struct cache_content{
	bool v;
	unsigned int tag;
//	unsigned int data[16];    
};

const int K=1024;

double log2( double n )  
{  
    // log(n)/log(2) is log2.  
    return log( n ) / log(double(2));  
}


void simulate(int cache_size, int block_size, char* filename){
	unsigned int tag,index,x;

	int offset_bit = (int) round(log2(block_size));
	int index_bit = (int) round(log2(cache_size/block_size));
	int line= cache_size>>(offset_bit);

	cache_content *cache =new cache_content[line];
//	cout<<"cache line:"<<line<<" ";
//	cout << offset_bit << " " << index_bit << " ";

	for(int j=0;j<line;j++)
		cache[j].v=false;
	
  	FILE * fp=fopen(filename,"r");		//read file
	
	float miss_num = 0, hit_num = 0;
	while(fscanf(fp,"%x",&x)!=EOF){
		//cout<<hex<<x<<" ";
		index=(x>>offset_bit)&(line-1);
		tag=x>>(index_bit+offset_bit);
		if(cache[index].v && cache[index].tag==tag){
			cache[index].v=true;			//hit
			hit_num++;		
		}
		else{						
			cache[index].v=true;			//miss
			cache[index].tag=tag;
			miss_num++;
		}
	}

	//cout << "hit_num: " << hit_num << endl;
	//cout << "miss_num: " << miss_num << endl;
	cout << cache_size << "-byte cache " << block_size << "-byte block: " << miss_num/(miss_num+hit_num)*100 << "%" << endl; 
	fclose(fp);

	delete [] cache;
}
	
int main(){
	// Let us simulate 4KB cache with 16B blocks
	
	cout << "------------ ICACHE ------------" << endl;
	for (int cache_size = 8; cache_size <= 1024; cache_size *= 2) 
		for (int block_size = 4; block_size <= 256; block_size *= 2) 
			if (block_size <= cache_size)
				simulate(cache_size, block_size, "ICACHE.txt");
	cout << endl;

	cout << "------------ DCACHE ------------" << endl;
	for (int cache_size = 8; cache_size <= 1024; cache_size *= 2) 
		for (int block_size = 4; block_size <= 256; block_size *= 2) 
			if (block_size <= cache_size)
				simulate(cache_size, block_size, "DCACHE.txt");
	return 0;
}

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


void simulate(int cache_size, int block_size, int set_size, char* filename){
	unsigned int tag,index,x;

	int offset_bit = (int) round(log2(block_size));
	int index_bit = (int) round(log2(cache_size/(block_size)));
	int line= cache_size>>(offset_bit);
	
	cache_content **cache =new cache_content*[line];
	for (int i = 0; i < line; i++)
		cache[i] = new cache_content[set_size];
//	cout<<"cache line:"<<line<<" ";
//	cout << offset_bit << " " << index_bit << " ";
	
	for (int i = 0; i < line; i++)
		for (int j = 0; j < set_size; j++)
			cache[i][j].v = false;
	
  	FILE * fp=fopen(filename,"r");		//read file
	
	float miss_num = 0, hit_num = 0;
	while(fscanf(fp,"%x",&x)!=EOF){
		//cout<<hex<<x<<" ";
		index=(x>>offset_bit)&(line-1);
		tag=x>>(index_bit+offset_bit);
		bool hit = false;
		for (int i = 0; i < set_size; i++) {
			if(cache[index][i].v && cache[index][i].tag==tag){
				cache[index][i].v=true;			//hit
				hit= true;
				break;
			}
		}
		if(hit){			//hit
			hit_num++;		
		}
		else{				//miss
			if (!cache[index][set_size-1].v) { // set has empty slot
				for (int i = 0; i < set_size; i++) {
					if(!cache[index][i].v){
						cache[index][i].v=true;
						cache[index][i].tag=tag;
						break;		
					}
				}
			}
			else {
				for (int i = 0; i < set_size-1; i++) {
					cache[index][i].tag=cache[index][i+1].tag;	
				}
				cache[index][set_size-1].v=true;			
				cache[index][set_size-1].tag=tag;
			}
			miss_num++;
		}
	}

	//cout << "hit_num: " << hit_num << endl;
	//cout << "miss_num: " << miss_num << endl;
	cout << cache_size/K << "K-byte cache " << set_size << "-way set: " << miss_num/(miss_num+hit_num)*100 << "%" << endl; 
	fclose(fp);

	delete [] cache;
}
	
int main(){
	// Let us simulate 4KB cache with 16B blocks
	
	cout << "------------ LU ------------" << endl;
	for (int cache_size = 1; cache_size <= 32; cache_size *= 2) 
		for (int set_size = 1; set_size <= 8; set_size *= 2)
			simulate(cache_size*K, 64, set_size, "LU.txt");
	cout << endl;

	cout << "------------ RADIX ------------" << endl;
	for (int cache_size = 1; cache_size <= 32; cache_size *= 2) 
		for (int set_size = 1; set_size <= 8; set_size *= 2)
			simulate(cache_size*K, 64, set_size, "RADIX.txt");
	return 0;
}

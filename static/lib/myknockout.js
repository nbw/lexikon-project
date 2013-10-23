// <!-- %%%%%%%%%%%%%%%%%%%%%%%% -->
			// <!--    KNOCKOUT functions    -->
			// <!-- %%%%%%%%%%%%%%%%%%%%%%%% -->

			function DictViewModel() {
				var self = this;

				self.searchValue = ko.observable();
				self.wordList = wordList;

				self.currSearch = ko.computed(function(){
					if(self.searchValue() !== undefined){
						if(self.searchValue().length >= 2 ){
							var list  = self.wordList.filter(function(str){
								formattedStr = self.searchValue().slice(0,1).toUpperCase()+
												self.searchValue().slice(1,self.searchValue().length).toLowerCase();
												console.log(formattedStr);
								return (str.startsWith(formattedStr))
								});
							if(list.length >0){
								var tableHTML = "<table>";
									for(i =0;i<list.length;i++){
										tableHTML += "<tr><td>" + list[i] + "</td></tr>"
									}
									tableHTML += "</table">
								$("#search-input,#search-input-collapsed ").attr('data-original-title',tableHTML); 
								$("#search-input,#search-input-collapsed").tooltip('show');
							}
							else{
								$("#search-input").tooltip('hide');
							}
							return list;
						}
					}
				
					$("#search-input").tooltip('hide')
					return undefined;
				});
			}


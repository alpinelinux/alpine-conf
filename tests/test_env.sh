PATH=$(atf_get_srcdir)/..:$(atf_get_srcdir)/bin:$PATH

init_env() {
	export ROOT=$PWD LIBDIR=$(atf_get_srcdir)/.. MOCK=echo
}

init_tests() {
	TESTS="$@"
	export TESTS
	for t; do
		atf_test_case $t
	done
}

atf_init_test_cases() {
	for t in $TESTS; do
		atf_add_test_case $t
	done
}

test_usage() {
	init_env
	atf_check -s exit:0 \
		-o match:"^usage: $@" \
		-e empty \
		$@ -h

	atf_check -s exit:1 \
		-o empty \
		-e match:"^usage: $@" \
		$@ -INVALID
}


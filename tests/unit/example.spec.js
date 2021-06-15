import { expect } from 'chai';
import { shallowMount } from '@vue/test-utils';
import FileInput from '@/components/FileInput.vue';

describe('FileInput.vue', () => {
  it('renders props.msg when passed', () => {
    const wrapper = shallowMount(FileInput, {
      propsData: { file: null, dragClass: '' },
    });
    expect(wrapper.text()).to.include('Select music XML file');
  });
});
